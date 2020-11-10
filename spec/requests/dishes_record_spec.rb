require 'rails_helper'

RSpec.describe "お料理登録", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "ログインしているユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_requests(user)
      get new_dish_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('dishes/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログインページにリダイレクトされること" do
      get new_dish_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
