require 'rails_helper'

RSpec.describe "お料理登録", type: :request do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_dish.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }

  context "ログインしているユーザーの場合" do
    before do
      get new_dish_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_dish_url
      end
    end

    it "有効な料理データで登録できること" do
      expect {
        post dishes_path, params: { dish: { name: "イカの塩焼き",
                                            description: "冬に食べたくなる、身体が温まる料理です",
                                            portion: 1.5,
                                            tips: "ピリッと辛めに味付けするのがオススメ",
                                            reference: "https://cookpad.com/recipe/2798655",
                                            required_time: 30,
                                            popularity: 5,
                                            picture: picture } }
      }.to change(Dish, :count).by(1)
      follow_redirect!
      expect(response).to render_template('dishes/show')
    end

    it "無効な料理データでは登録できないこと" do
      expect {
        post dishes_path, params: { dish: { name: "",
                                            description: "冬に食べたくなる、身体が温まる料理です",
                                            portion: 1.5,
                                            tips: "ピリッと辛めに味付けするのがオススメ",
                                            reference: "https://cookpad.com/recipe/2798655",
                                            required_time: 30,
                                            popularity: 5,
                                            picture: picture } }
      }.not_to change(Dish, :count)
      expect(response).to render_template('dishes/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_dish_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
