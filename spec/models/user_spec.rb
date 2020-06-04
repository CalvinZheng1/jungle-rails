require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:each) do
      @user = User.new(name: "Amanda", email: "hello@gmail.com", password: "test", password_confirmation: "test")
    end

    it "should have a name" do
      @user.name = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it "should have an email" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "should have a password" do
      @user.password = nil
      @user.password_confirmation = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank", "Password confirmation can't be blank")
    end
    it "should confirm password" do
      @user.password = "test"
      @user.password_confirmation = "Test"
      @user.save
      expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
    end
    it "password should be longer than 3 characters" do
      @user.password = "t"
      @user.password_confirmation = "t"
      @user.valid?
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(name: "Amanda", email: "hello@gmail.com", password: "test", password_confirmation: "test")
    end
    
    it "should be no spaces" do
      @user.email = " hello@gmail.com "
      @user.valid?
      expect(@user.errors.full_messages).to include ("Email must contain no spaces")
    end
  end
end