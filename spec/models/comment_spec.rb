require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }

  context "バリデーション" do
    it "有効であること" do
      expect(comment).to be_valid
    end

    it "user_idがnilの場合無効であること" do
      comment = build(:comment, user_id: nil)
      expect(comment).not_to be_valid
    end

    it "dish_idがnilの場合無効であること" do
      comment = build(:comment, dish_id: nil)
      expect(comment).not_to be_valid
    end

    it "内容がnilの場合無効であること" do
      comment = build(:comment, content: nil)
      expect(comment).not_to be_valid
    end

    it "内容が50文字以内であること" do
      comment = build(:comment, content: "あ" * 51)
      comment.valid?
      expect(comment.errors[:content]).to include("は50文字以内で入力してください")
    end
  end
end
