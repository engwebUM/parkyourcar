require 'rails_helper'

describe Review do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:review)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'evaluation' do
        expect(FactoryGirl.build(:review, evaluation: nil)).not_to be_valid
      end

      it 'comment' do
        expect(FactoryGirl.build(:review, comment: nil)).not_to be_valid
      end
    end

    context 'with evaluation' do
      it 'inferior to permitted' do
        expect(FactoryGirl.build(:review, evaluation: 0)).not_to be_valid
      end

      it 'superior to permitted' do
        expect(FactoryGirl.build(:review, evaluation: 6)).not_to be_valid
      end
    end
  end
end