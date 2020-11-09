# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StaticPages', type: :system do
  describe 'トップページ' do
    context 'ページ全体' do
      before do
        visit root_path
      end

      it 'クック-ウィズの文字列が存在することを確認' do
        expect(page).to have_content 'クック-ウィズ'
      end

      it '正しいタイトルが表示されることを確認' do
        expect(page).to have_title full_title
      end
    end

    context "料理フィード", js: true do
      let!(:user) { create(:user) }
      let!(:dish) { create(:dish, user: user) }

      it "料理のぺージネーションが表示されること" do
        login_for_system(user)
        create_list(:dish, 6, user: user)
        visit root_path
        expect(page).to have_content "みんなの料理 (#{user.dishes.count})"
        expect(page).to have_css "div.pagination"
        Dish.take(5).each do |d|
          expect(page).to have_link d.name
        end
      end
    end
  end

  describe 'ヘルプページ' do
    before do
      visit about_path
    end

    it 'クック-ウィズとは？の文字列が存在することを確認' do
      expect(page).to have_content 'クック-ウィズとは？'
    end

    it '正しいタイトルが表示されることを確認' do
      expect(page).to have_title full_title('クック-ウィズとは？')
    end
  end

  describe '利用規約ページ' do
    before do
      visit use_of_terms_path
    end

    it '利用規約の文字列が存在することを確認' do
      expect(page).to have_content '利用規約'
    end

    it '正しいタイトルが表示されることを確認' do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
