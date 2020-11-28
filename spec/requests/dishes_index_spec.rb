require "rails_helper"

RSpec.describe "料理一覧ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "ログインしている場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get dishes_path
      expect(response).to have_http_status "200"
      expect(response).to render_template('dishes/index')
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトされること" do
      get dishes_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
