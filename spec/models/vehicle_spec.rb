require 'rails_helper'

describe Vehicle do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:vehicle)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'plate' do
        expect(FactoryGirl.build_stubbed(:vehicle, plate: nil)).to be_invalid
      end
    end

    context 'with repeated' do
      it 'plates' do
        FactoryGirl.create(:vehicle, plate: '00-AA-00')
        expect(FactoryGirl.build_stubbed(:vehicle, plate: '00-AA-00')).to be_invalid
      end
    end
  end
end
