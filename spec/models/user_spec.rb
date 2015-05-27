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

  describe '#photo' do
    context 'with an avatar' do
      it 'returns user\'s avatar'
    end

    context 'without an avatar' do
      it 'returns the standard one' do
        user = FactoryGirl.build_stubbed(:user, avatar: nil)
        expect(user.photo).to eq 'user_avatar.png'
      end
    end
  end

  describe '#phone' do
    context 'with a number' do
      it 'returns user\'s number' do
        expect(FactoryGirl.build_stubbed(:user, phone_number: 123_456_789).phone).to eq 123_456_789
      end
    end

    context 'without a number' do
      it 'returns \'Not available\'' do
        expect(FactoryGirl.build_stubbed(:user, phone_number: nil).phone).to eq 'Not available'
      end
    end
  end

  describe '#birthdate' do
    context 'with a date of birth' do
      it 'returns it' do
        dob = DateTime.current.to_date - 20.years
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: dob).birthdate).to eq dob
      end
    end

    context 'without a date of birth' do
      it 'returns \'Not available\'' do
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: nil).birthdate).to eq 'Not available'
      end
    end
  end

  describe '#valid_age' do
    before do
      @today = DateTime.current.to_date
    end

    context 'returns nil' do
      it 'without a date of birth' do
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: nil).valid_age).to eq nil
      end
      it 'with more than 18 years' do
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: @today - 20.years).valid_age).to eq nil
      end
      it 'with exactly 18 years' do
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: @today - 18.years).valid_age).to eq nil
      end
    end

    context 'returns an object containing \'You must be 18 years or older.\'' do
      it 'with less than 18 years' do
        expect(FactoryGirl.build_stubbed(:user, date_of_birth: @today - 16.years).valid_age).to include 'You must be 18 years or older.'
      end
    end
  end

  describe '#==' do
    context 'with equal users' do
      it 'returns true' do
        user1 = FactoryGirl.build_stubbed(:user)
        user2 = user1
        expect(user1 == user2).to eq true
      end
    end

    context 'with different users' do
      it 'returns false' do
        user1 = FactoryGirl.build_stubbed(:user)
        user2 = FactoryGirl.build_stubbed(:user)
        expect(user1 == user2).to eq false
      end
    end
  end
end
