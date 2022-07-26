require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end


  it "email, password, nameがある場合、有効" do
    expect(@user).to be_valid
  end

  it "emailがない場合、無効" do
    @user.email = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Email can't be blank")
  end

  it "nameがない場合、無効" do
    @user.name = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Name can't be blank")
  end


  it "passwordがない場合、無効" do
    @user.password = nil
    @user.valid?
    expect(@user.errors.full_messages).to include("Password can't be blank")
  end
end
