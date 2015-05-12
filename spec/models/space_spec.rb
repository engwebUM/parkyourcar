require 'rails_helper'

describe Space do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:space)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'title' do
        expect(FactoryGirl.build(:space, title: nil)).not_to be_valid
      end

      it 'available spaces' do
        expect(FactoryGirl.build(:space, available_spaces: nil)).not_to be_valid
      end

      it 'description' do
        expect(FactoryGirl.build(:space, description: nil)).not_to be_valid
      end

      it 'country' do
        expect(FactoryGirl.build(:space, country: nil)).not_to be_valid
      end

      it 'city' do
        expect(FactoryGirl.build(:space, city: nil)).not_to be_valid
      end

      it 'address' do
        expect(FactoryGirl.build(:space, address: nil)).not_to be_valid
      end

      it 'post code' do
        expect(FactoryGirl.build(:space, post_code: nil)).not_to be_valid
      end

      it 'price per hour' do
        expect(FactoryGirl.build(:space, price_hour: nil)).not_to be_valid
      end

      it 'initial date' do
        expect(FactoryGirl.build(:space, date_from: nil)).not_to be_valid
      end

      it 'final date' do
        expect(FactoryGirl.build(:space, date_until: nil)).not_to be_valid
      end
    end

    context 'with zero' do
      it 'available spaces' do
        expect(FactoryGirl.build(:space, available_spaces: 0)).not_to be_valid
      end

      it 'as price per hour' do
        expect(FactoryGirl.build(:space, price_hour: 0)).not_to be_valid
      end

      it 'as price per week' do
        expect(FactoryGirl.build(:space, price_week: 0)).not_to be_valid
      end

      it 'as price per month' do
        expect(FactoryGirl.build(:space, price_month: 0)).not_to be_valid
      end
    end
  end
end
