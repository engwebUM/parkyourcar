require 'rails_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'first name' do
        expect(FactoryGirl.build(:user, first_name: nil)).not_to be_valid
      end

      it 'last name' do
        expect(FactoryGirl.build(:user, last_name: nil)).not_to be_valid
      end

      it 'username' do
        expect(FactoryGirl.build(:user, username: nil)).not_to be_valid
      end

      it 'email' do
        expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
      end
    end

    context 'with repeated' do
      it 'usernames' do
        FactoryGirl.create(:user, username: 'creative_username')
        expect(FactoryGirl.build(:user, username: 'creative_username')).not_to be_valid
      end

      it 'emails' do
        FactoryGirl.create(:user, email: 'repeated@email.com')
        expect(FactoryGirl.build(:user, email: 'repeated@email.com')).not_to be_valid
      end

      it 'phone numbers' do
        FactoryGirl.create(:user, phone_number: 999_999_999)
        expect(FactoryGirl.build(:user, phone_number: 999_999_999)).not_to be_valid
      end
    end
  end
end
