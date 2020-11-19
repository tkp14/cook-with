require 'rails_helper'

RSpec.describe Log, type: :model do
  let!(:log) { create(:log) }

  it "ログが有効であること" do
    expect(log).to be_valid
  end

  it "dish_idがnilの場合、無効であること" do
    log = build(:log, dish_id: nil)
    expect(log).not_to be_valid
  end
end
