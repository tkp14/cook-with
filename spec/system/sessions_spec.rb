require 'rails_helper'

RSpec.describe "Sessions", type: :system do
  let!(:user) { create(:user) }

     before do
       visit login_path
     end

  describe "ログインページ" do
    context "ページレイアウト" do
      it "ログインの文字列が存在する事" do
        expect(page).to have_content "ログイン"
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ログイン')
      end

      it "ログインフォームのラベルが正しく表示される" do
        expect(page).to have_content 'メールアドレス'
        expect(page).to have_content 'パスワード'
      end

      it "ログインフォームが正しく表示される" do
        expect(page).to have_css 'input#user_email'
        expect(page).to have_css 'input#user_password'
      end

      it "ログインボタンが表示される" do
        expect(page).to have_button 'ログイン'
      end
    end
  end
end
