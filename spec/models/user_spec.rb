require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe 'presence' do
      subject {
        described_class.new(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")
      }

      it "is valid with valid attributes" do
        expect(subject).to be_valid
      end

      it "is not valid without a first_name" do
        subject.first_name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a last_name" do
        subject.last_name = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without an email" do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a password" do
        subject.password = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a password confirmation" do
        subject.password_confirmation = nil
        expect(subject).to_not be_valid
      end
    end

    describe 'password' do
      it 'is not valid if password and password confirmation do not match' do
        user = User.new(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "badmatch")

        expect(user).to_not be_valid
      end

      it 'is not valid if email is unique' do
        user1 = User.create(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")

        user2 = User.new(first_name: "Anything2", last_name: "Schmidt2", email: "test@example.com", password: "password", password_confirmation: "password")

        expect(user2).to_not be_valid
      end

      it 'should consider uniqueness as case-insensitive' do
        user1 = User.create(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")

        user2 = User.new(first_name: "Anything2", last_name: "Schmidt2", email: "TEST@example.com", password: "password", password_confirmation: "password")

        expect(user2).to_not be_valid
      end

      it 'should not be valid if passwords are shorter than 6 characters' do
        user = User.new(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "pass", password_confirmation: "pass")

        expect(user).to_not be_valid 
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return the correct user if the email and password match' do
      user = User.create!(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")

      authUser = User.authenticate_with_credentials("test@example.com", "password")

      expect(authUser).to eql(user)
    end

    it 'should return nil if the email and password do not match' do
      user = User.create!(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")

      authUser = User.authenticate_with_credentials("test@example.com", "wrong")

      expect(authUser).to be_nil
    end

    it 'should disregard spaces' do
      user = User.create!(first_name: "Anything", last_name: "Schmidt", email: "test@example.com", password: "password", password_confirmation: "password")

      authUser = User.authenticate_with_credentials(" test@example.com ", "password")

      expect(authUser).to eql(user)
    end

    it 'should make emails case-insensitive' do
      user = User.create!(first_name: "Anything", last_name: "Schmidt", email: "eXample@domain.COM", password: "password", password_confirmation: "password")

      authUser = User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", "password")

      expect(authUser).to eql(user)
    end
  end
end