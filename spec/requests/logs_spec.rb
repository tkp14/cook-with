require 'rails_helper'

RSpec.describe "ログ機能", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:log) { create(:log, dish: dish) }

  context "ログ登録" do
    context "ログインしている場合" do
    end

    context "ログインしていない場合" do
      it "登録出来ずログインページへリダイレクトされること" do
        expect {
          post logs_path, params: { dish_id: dish.id,
                                        log: { content: "醤油の味が濃すぎた" } }
        }.not_to change(dish.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end

  context "ログ削除" do
    context "ログインしている場合" do
    end

    context "ログインしていない場合" do
      it "削除出来ずログインページへリダイレクトされること" do
        expect {
        delete log_path(log)
        }.not_to change(dish.logs, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
