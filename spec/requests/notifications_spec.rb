require 'rails_helper'

RSpec.describe "通知機能", type: :request do
  let!(:user) { create(:user) }

  context "通知一覧ページの表示" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "レスポンスが正常に表示されること" do
        get notifications_path
        expect(response).to render_template('notifications/index')
      end
    end

    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        get notifications_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
