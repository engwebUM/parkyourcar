require 'rails_helper'

describe Favorite do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:favorite)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      context 'associated' do
        it 'user' do
          expect(FactoryGirl.build_stubbed(:favorite, user: nil)).to be_invalid
        end

        it 'space' do
          expect(FactoryGirl.build_stubbed(:favorite, space: nil)).to be_invalid
        end
      end
    end
  end
end
