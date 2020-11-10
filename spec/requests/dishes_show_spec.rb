require 'rails_helper'

RSpec.describe "料理詳細ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "ログイン済のユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get dish_path(dish)
      expect(response).to have_http_status "200"
      expect(response).to render_template('dishes/show')
    end
  end
end
