require 'rails_helper'

describe Space do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:space)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'title' do
        expect(FactoryGirl.build_stubbed(:space, title: nil)).to be_invalid
      end

      it 'available spaces' do
        expect(FactoryGirl.build_stubbed(:space, available_spaces: nil)).to be_invalid
      end

      it 'description' do
        expect(FactoryGirl.build_stubbed(:space, description: nil)).to be_invalid
      end

      it 'country' do
        expect(FactoryGirl.build_stubbed(:space, country: nil)).to be_invalid
      end

      it 'city' do
        expect(FactoryGirl.build_stubbed(:space, city: nil)).to be_invalid
      end

      it 'address' do
        expect(FactoryGirl.build_stubbed(:space, address: nil)).to be_invalid
      end

      it 'post code' do
        expect(FactoryGirl.build_stubbed(:space, post_code: nil)).to be_invalid
      end

      it 'price per hour' do
        expect(FactoryGirl.build_stubbed(:space, price_hour: nil)).to be_invalid
      end

      it 'initial date' do
        expect { FactoryGirl.build_stubbed(:space, date_from: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      it 'final date' do
        expect { FactoryGirl.build_stubbed(:space, date_until: nil).valid? }.
          to raise_error(NoMethodError, "undefined method `to_datetime' for nil:NilClass")
      end

      context 'associated' do
        it 'user' do
          expect(FactoryGirl.build_stubbed(:space, user: nil)).to be_invalid
        end
      end
    end

    context 'with zero' do
      it 'available spaces' do
        expect(FactoryGirl.build_stubbed(:space, available_spaces: 0)).to be_invalid
      end

      it 'as price per hour' do
        expect(FactoryGirl.build_stubbed(:space, price_hour: 0)).to be_invalid
      end

      it 'as price per week' do
        expect(FactoryGirl.build_stubbed(:space, price_week: 0)).to be_invalid
      end

      it 'as price per month' do
        expect(FactoryGirl.build_stubbed(:space, price_month: 0)).to be_invalid
      end
    end
  end

  describe '#filter_by' do
    before do
      @today = DateTime.current
    end

    context '\'date_from\'' do
      it 'returns spaces with a prior (or equal) initial date to filter\'s initial date' do
        space_a = FactoryGirl.create(:space, date_from: @today - 1.week)
        space_b = FactoryGirl.create(:space, date_from: @today)
        FactoryGirl.create(:space, date_from: @today + 1.week)
        expect(Space.filter_by(@today, nil, nil)).to contain_exactly(space_a, space_b)
      end
    end

    context '\'date_until\'' do
      it 'returns spaces with a posterior (or equal) final date to filter\'s final date' do
        FactoryGirl.create(:space, date_until: @today - 1.week)
        space_a = FactoryGirl.create(:space, date_until: @today)
        space_b = FactoryGirl.create(:space, date_until: @today + 1.week)
        expect(Space.filter_by(nil, @today, nil)).to contain_exactly(space_a, space_b)
      end
    end

    context '\'weekend_availability\'' do
      before do
        @space_a = FactoryGirl.create(:space, available_weekend: true)
        @space_b = FactoryGirl.create(:space, available_weekend: false)
      end

      it 'if \'true\' returns spaces with weekend availability' do
        expect(Space.filter_by(nil, nil, 'true')).to contain_exactly(@space_a)
      end

      it 'otherwise returns spaces regardless of weekend availability' do
        expect(Space.filter_by(nil, nil, false)).to contain_exactly(@space_a, @space_b)
      end
    end
  end

  describe '#sort_by' do
    before do
      @space_a = FactoryGirl.create(:space, price_hour: 2, address: 'Broadway', city: 'New York', country: 'USA')
      @space_b = FactoryGirl.create(:space, price_hour: 3, address: 'Times Square', city: 'New York', country: 'USA')
      @space_c = FactoryGirl.create(:space, price_hour: 1, address: 'Allen Street', city: 'New York', country: 'USA')
      @spaces = Space.near('New York', 20) # Spaces are pre-sorted by distance when a search is made
    end

    context 'without parameter' do
      it 'returns spaces pre-sorted by distance' do
        expect(@spaces.sort_by(nil)).to eq [@space_c, @space_b, @space_a]
      end
    end

    context '\'pri\'' do
      it 'returns spaces re-sorted by price per hour' do
        expect(@spaces.sort_by('pri')).to eq [@space_c, @space_a, @space_b]
      end
    end

    context '\'rev\'' do
      it 'returns spaces re-sorted by number of reviews' do
        1.times { FactoryGirl.create(:review, space: @space_a) }
        3.times { FactoryGirl.create(:review, space: @space_b) }
        2.times { FactoryGirl.create(:review, space: @space_c) }
        expect(@spaces.sort_by('rev')).to eq [@space_b, @space_c, @space_a]
      end

      it 'includes spaces without reviews' do
        FactoryGirl.create(:review, space: @space_a)
        expect(@spaces.sort_by('rev')).to include(@space_b, @space_c)
      end
    end
  end

  describe '#near' do
    it 'returns places within given distance' do
      space = FactoryGirl.create(:space, price_hour: 2, address: 'Allen Street', city: 'New York', country: 'USA')
      FactoryGirl.create(:space, price_hour: 3, address: '1263 California St', city: 'Mountain View', country: 'USA')
      expect(Space.near('New York', 20)).to contain_exactly(space)
    end
  end

  describe '#valid_date?' do
    context 'when valid' do
      it 'returns a truthy value' do
        expect(Space.valid_date?(DateTime.current)).to be_truthy
      end
    end

    context 'when invalid' do
      it 'returns false' do
        expect(Space.valid_date?('not a valid date')).to eq false
      end
    end
  end

  describe '#owner_avatar' do
    it 'returns owner\'s avatar' do
      user = FactoryGirl.build_stubbed(:user)
      expect(FactoryGirl.build_stubbed(:space, user: user).owner_avatar).to eq user.photo
    end
  end

  describe '#owner_rating' do
    before do
      @user = FactoryGirl.build_stubbed(:user)
      @space_a = FactoryGirl.build(:space, user: @user)
      @space_b = FactoryGirl.build(:space, user: @user)
    end

    context 'without reviews to any of owner\'s spaces' do
      it 'returns 0' do
        expect(@space_a.owner_rating).to eq 0
      end
    end

    context 'with reviews' do
      before do
        FactoryGirl.create(:review, space: @space_a, evaluation: 1)
        FactoryGirl.create(:review, space: @space_b, evaluation: 2)
      end

      it 'returns the average rating from all owner\'s spaces' do
        expect(@space_a.owner_rating).to eq 1.5
      end

      it 'returns the average rating with a precision of two decimal points' do
        FactoryGirl.create(:review, space: @space_b, evaluation: 2)
        expect(@space_a.owner_rating).to eq 1.67
      end
    end
  end

  describe '#first_image' do
    before do
      @space = FactoryGirl.build_stubbed(:space)
    end

    context 'without images' do
      it 'returns the standard one' do
        expect(@space.first_image).to eq 'no_image.png'
      end
    end

    context 'with one image' do
      it 'returns that image' do
        image = FactoryGirl.create(:attachment, space: @space)
        expect(@space.first_image).to eq image.file_name.url(:thumb)
        image.file_name.remove!
      end
    end

    context 'with multiple images' do
      it 'returns the first one' do
        image_a = FactoryGirl.create(:attachment, space: @space)
        image_b = FactoryGirl.create(:attachment, space: @space)
        expect(@space.first_image).to eq image_a.file_name.url(:thumb)
        image_a.file_name.remove!
        image_b.file_name.remove!
      end
    end
  end

  describe '#weekend' do
    context 'without availability' do
      it 'returns \'excluding weekends\'' do
        space = FactoryGirl.build_stubbed(:space, available_weekend: false)
        expect(space.weekend).to eq 'excluding weekends'
      end
    end

    context 'with availability' do
      it 'returns \'including weekends\'' do
        space = FactoryGirl.build_stubbed(:space, available_weekend: true)
        expect(space.weekend).to eq 'including weekends'
      end
    end
  end
end
