require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    user = FactoryBot.create(:user, email: 'sample@sample.com')
    post = FactoryBot.create(:post, user: user)
    @like = FactoryBot.build(:like, user: user, likable: post )
  end

  it "user_id,likableがある場合、有効" do
    expect(@like).to be_valid
  end

  it "user_idがない場合、無効" do
    @like.user_id = nil
    @like.valid?
    expect(@like.errors.full_messages).to include("User must exist")
  end

  it "likableがない場合、無効" do
    @like.likable_id = nil
    @like.valid?
    expect(@like.errors.full_messages).to include("Likable must exist")
  end
end
