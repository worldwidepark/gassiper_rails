require 'rails_helper'

RSpec.describe Follow, type: :model do
  before do
    user_a = FactoryBot.create(:user, email: 'sample@sample.com')
    user_b = FactoryBot.create(:user, email: 'sample2@sample.com')
    @follow = FactoryBot.build(:follow, followed: user_a, follower: user_b )
  end

  it "user_id,likableがある場合、有効" do
    expect(@follow).to be_valid
  end

  it "user_idがない場合、無効" do
    @follow.follower_id = nil
    @follow.valid?
    expect(@follow.errors.full_messages).to include("Follower must exist", "Follower can't be blank")
  end

  it "likableがない場合、無効" do
    @follow.followed_id = nil
    @follow.valid?
    expect(@follow.errors.full_messages).to include("Followed must exist", "Followed can't be blank")
  end
end
