require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:favorite) { create(:favorite) }

  it "お気に入りが有効であること" do
    expect(favorite).to be_valid
  end

  it "user_idがnilの場合無効であること" do
    favorite.user_id = nil
    expect(favorite).not_to be_valid
  end

  it "dish_idがnilの場合無効であること" do
    favorite.dish_id = nil
    expect(favorite).not_to be_valid
  end
end
