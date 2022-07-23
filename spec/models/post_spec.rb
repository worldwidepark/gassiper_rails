require 'rails_helper'

RSpec.describe Post, type: :model do
  it "textがある場合、有効" do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end

  it "textがない場合、無効" do
    post = FactoryBot.build(:post, text: nil)
    post.valid?
    expect(post.errors.full_messages).to include("Text is too short (minimum is 1 character)")
  end
end
