require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:relationship) { create(:relationship) }
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }

  it "関係性が有効であること" do
    expect(relationship).to be_valid
  end

  it "follower_idがnilの場合、関係性が無効であること" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "followed_idがnilの場合、関係性が無効であること" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end

  context "フォロー機能" do
    it "フォローとアンフォローが正常に動作すること" do
      expect(user.following?(other_user)).to be_falsey
      user.follow(other_user)
      expect(user.following?(other_user)).to be_truthy
      user.unfollow(other_user)
      expect(user.following?(other_user)).to be_falsey
    end
  end
end
