require 'rails_helper'

describe Vehicle do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:vehicle)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'plate' do
        expect(FactoryGirl.build(:vehicle, plate: nil)).not_to be_valid
      end
    end

    context 'with repeated' do
      it 'plates' do
        FactoryGirl.create(:vehicle, plate: '00-AA-00')
        expect(FactoryGirl.build(:vehicle, plate: '00-AA-00')).not_to be_valid
      end
    end
  end
end
