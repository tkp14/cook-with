require 'rails_helper'

RSpec.describe "通知機能", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:other_dish) { create(:dish, user: other_user) }
  
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

  context "通知処理" do
    before do
      login_for_request(user)
    end

    context "自分以外のユーザーの料理に対して" do
      it "お気に入りした場合、そのユーザーに通知が行くこと" do
        post "/favorites/#{other_dish.id}/create"
        expect(other_user.reload.notification).to be_truthy
      end

      it "コメントした場合、そのユーザーに通知が行くこと" do
        post comments_path, params: { dish_id: other_dish.id,
                                      comment: { content: "最高です！" } }
        expect(other_user.reload.notification).to be_truthy
      end
    end

    context "自分の料理に対して" do
      it "お気に入りした場合、通知がこないこと" do
        post "/favorites/#{dish.id}/create"
        expect(user.reload.notification).to be_falsey
      end

      it "コメントした場合、通知がこないこと" do
        post comments_path, params: { dish_id: dish.id,
                                      comment: { content: "最高です！" } }
        expect(user.reload.notification).to be_falsey
      end
    end
  end
end
