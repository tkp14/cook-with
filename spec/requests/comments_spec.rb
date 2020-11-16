require 'rails_helper'

RSpec.describe "コメント機能", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish) }
  let!(:comment) { create(:comment, user_id: user.id, dish: dish) }

  context "コメントの登録" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "有効な内容のコメントができること" do
        expect {
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: "最高です！" } }
        }.to change(dish.comments, :count).by(1)
      end

      it "無効な内容の場合はコメント出来ないこと" do
        expect {
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: "" } }
        }.not_to change(dish.comments, :count)
      end
    end

    context "ログインしていない場合" do
      it "コメントは出来ずにログインページへリダイレクトされること" do
        expect {
          post comments_path, params: { dish_id: dish.id,
                                        comment: { content: "最高です！" } }
        }.not_to change(dish.comments, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "コメントの削除" do
    context "ログインしている場合" do
      context "コメントを作成したユーザーである場合" do
        it "コメントの削除ができること" do
          login_for_request(user)
          expect {
            delete comment_path(comment)
          }.to change(dish.comments, :count).by(-1)
        end
      end

      context "コメントを作成したユーザーでない場合" do
        it "コメントの削除はできないこと" do
          login_for_request(other_user)
            expect {
              delete comment_path(comment)
            }.not_to change(dish.comments, :count)
        end
      end
    end

    context "ログインしていない場合" do
      it "コメントの削除は出来ずにログインページへリダイレクトされること" do
        expect {
          delete comment_path(comment)
        }.not_to change(dish.comments, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
