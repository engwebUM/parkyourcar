require 'rails_helper'

describe Booking do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:booking_sent)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'initial date' do
        expect { FactoryGirl.build_stubbed(:booking, date_from: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      it 'final date' do
        expect { FactoryGirl.build_stubbed(:booking, date_until: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      context 'associated' do
        it 'user' do
          expect(FactoryGirl.build_stubbed(:booking, user: nil)).to be_invalid
        end

        it 'space' do
          expect { Factor.build_stubbed(:booking, space: nil).valid? }.
            to raise_error(NameError, 'uninitialized constant Factor')
        end

        it 'vehicle' do
          expect(FactoryGirl.build_stubbed(:booking, vehicle: nil)).to be_invalid
        end
      end
    end

    context 'with' do
      before do
        @today = DateTime.current
      end

      it 'invalid datetime on initial date' do
        expect { FactoryGirl.build_stubbed(:booking, date_from: 'not a valid date').valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      it 'invalid datetime on final date' do
        expect { FactoryGirl.build_stubbed(:booking, date_until: 'not a valid date').valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      it 'repeated initial and final dates' do
        expect(FactoryGirl.build_stubbed(:booking, date_from: @today + 1.week, date_until: @today + 1.week)).
          to be_invalid
      end

      it 'inverted initial and final dates' do
        expect(FactoryGirl.build_stubbed(:booking, date_from: @today + 2.weeks, date_until: @today + 1.week)).
          to be_invalid
      end

      it 'initial date prior to space\'s initial date' do
        space = FactoryGirl.build_stubbed(:space, date_from: @today, date_until: @today + 1.month)
        expect(FactoryGirl.build_stubbed(:booking, space: space, date_from: @today - 1.week, date_until: @today + 1.week)).
          to be_invalid
      end

      it 'final date posterior to  space\'s final date' do
        space = FactoryGirl.build_stubbed(:space, date_from: @today, date_until: @today + 1.month)
        expect(FactoryGirl.build_stubbed(:booking, space: space, date_from: @today + 1.week, date_until: @today + 2.months)).
          to be_invalid
      end

      # => should we implement this validation?
      xit 'booking\'s user being the same as booked space\'s owner' do
        owner = FactoryGirl.build_stubbed(:user)
        space = FactoryGirl.build_stubbed(:space, user: owner)
        expect(FactoryGirl.build_stubbed(:booking, space: space, user: owner)).
          to be_valid
      end
    end
  end

  describe '#owner' do
    it 'returns owner of booked space' do
      owner = FactoryGirl.build_stubbed(:user)
      space = FactoryGirl.build_stubbed(:space, user: owner)
      booking = FactoryGirl.build_stubbed(:booking, space: space)
      expect(booking.owner).to eq owner
    end
  end
end
