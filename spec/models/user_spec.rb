require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    User.new(
      first_name: "Warren",
      last_name: "Roque",
      email: "abc@email.com",
      password: "1234",
      password_confirmation: "1234"
    )
  }

  describe 'Validations' do

    it 'should create a new user' do
      expect(subject).to be_valid
    end

    it 'should be invalid without first name' do
      subject.first_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "First name can't be blank"
    end

    it 'should be invalid without last_name' do
      subject.last_name = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Last name can't be blank"
    end

    it 'should be invalid without email' do
      subject.email = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Email can't be blank"
    end

    it 'should be invalid without password' do
      subject.password = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password can't be blank"
    end

    it 'should be invalid without password confirmation' do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password confirmation can't be blank"
    end

    it 'should be invalid if password & password confirmation do not match' do
      subject.password = 'abc'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it 'should be invalid if email already exists - not case sensitive' do
      subject1 = User.create(
        first_name: "War",
        last_name: "Roque",
        email: "ABC@email.com",
        password: "1234",
        password_confirmation: "1234"
      )
      subject2 = User.create(
        first_name: "Warr",
        last_name: "Roque",
        email: "ABC@email.com",
        password: "1234",
        password_confirmation: "1234"
      )
      expect(subject2).to_not be_valid
      expect(subject2.errors.full_messages).to include "Email has already been taken"
    end

    it 'should be invalid if password length is too short' do
      subject.password = '2'
      subject.password_confirmation = '2'
      expect(subject).to_not be_valid
      expect(subject.errors.full_messages).to include "Password is too short (minimum is 3 characters)"
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should log in with correct credentials' do
      subject.save!
      user = User.authenticate_with_credentials(subject.email, subject.password)
      expect(user).to eq(subject)
    end

    it 'does not log in with incorrect email' do
      subject.save!
      user = User.authenticate_with_credentials("test@email.com", subject.password)
      expect(user).to eq(nil)
    end

    it 'does not log in with incorrect password' do
      subject.save!
      user = User.authenticate_with_credentials(subject.email, '1')
      expect(user).to eq(nil)
    end

    it 'logs in if emails have spaces' do
      subject.save!
      user = User.authenticate_with_credentials("    " + subject.email + "  ", subject.password)
      expect(user).to eq(subject)
    end

    it 'logs in with non case sensitive email' do
      subject.save!
      user = User.authenticate_with_credentials('ABC@EMAIL.COM', subject.password)
      expect(user).to eq(subject)
    end

  end

end
