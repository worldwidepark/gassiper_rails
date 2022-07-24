require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user: user)
    @comment = FactoryBot.build(:comment, user: user, post: post)
  end
  it "textがある場合、有効" do
    expect(@comment).to be_valid
  end

  it "textがない場合、無効" do
    @comment.text = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include("Text can't be blank", "Text is too short (minimum is 1 character)")
  end

  it "userがない場合、無効" do
    @comment.user_id = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include("User must exist")
  end

  it "postがない場合、無効" do
    @comment.post_id = nil
    @comment.valid?
    expect(@comment.errors.full_messages).to include("Post must exist")
  end
end

