require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post, user: user)
  end
  it "textとuserがある場合、有効" do
    expect(@post).to be_valid
  end

  it "textがない場合、無効" do
    @post.text = nil
    @post.valid?
    expect(@post.errors.full_messages).to include("Text can't be blank", "Text is too short (minimum is 1 character)")
  end

  it "userがない場合、無効" do
    @post.user_id = nil
    @post.valid?
    expect(@post.errors.full_messages).to include("User can't be blank", "User must exist")
  end
end

