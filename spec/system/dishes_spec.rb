require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  describe "料理の登録ページ" do
    before do
      login_for_system(user)
      visit new_dish_path
    end

    context "ページレイアウト" do
      it "「料理の登録」の文字列が存在すること" do
        expect(page).to have_content '料理の登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('料理の登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '料理名'
        expect(page).to have_content '説明'
        expect(page).to have_content '分量 [人分]'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '作り方参照用URL'
        expect(page).to have_content '所要時間 [分]'
        expect(page).to have_content '人気度 [1~5]'
        expect(page).to have_content 'クックメモ'
      end
    end

    context "ユーザー登録処理" do
      it "有効な情報で料理登録を行うと料理登録成功のフラッシュが表示されること" do
        fill_in "料理名", with: "イカの塩焼き"
        fill_in "説明", with: "冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 1.5
        fill_in "コツ・ポイント", with: "ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方参照用URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 30
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "料理が登録されました！"
      end

      it "無効な情報で料理登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "料理名", with: ""
        fill_in "説明", with: "冬に食べたくなる、身体が温まる料理です"
        fill_in "分量", with: 1.5
        fill_in "コツ・ポイント", with: "ピリッと辛めに味付けするのがオススメ"
        fill_in "作り方参照用URL", with: "https://cookpad.com/recipe/2798655"
        fill_in "所要時間", with: 30
        fill_in "人気度", with: 5
        click_button "登録する"
        expect(page).to have_content "料理名を入力してください"
      end
    end
  end

  describe "料理詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit dish_path(dish)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{dish.name}")
      end

      it "料理情報が表示されること" do
        expect(page).to have_content dish.name
        expect(page).to have_content dish.description
        expect(page).to have_content dish.portion
        expect(page).to have_content dish.tips
        expect(page).to have_content dish.reference
        expect(page).to have_content dish.required_time
        expect(page).to have_content dish.popularity
      end
    end
  end
end
