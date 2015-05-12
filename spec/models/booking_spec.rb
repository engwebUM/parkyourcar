require 'rails_helper'

describe Booking do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:booking_sent)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'initial date' do
        expect { FactoryGirl.build(:booking, date_from: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      it 'final date' do
        expect { FactoryGirl.build(:booking, date_until: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end
    end
  end
end
