require 'rails_helper'

describe Review do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:review)).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      it 'evaluation' do
        expect(FactoryGirl.build_stubbed(:review, evaluation: nil)).not_to be_valid
      end

      it 'comment' do
        expect(FactoryGirl.build_stubbed(:review, comment: nil)).not_to be_valid
      end

      context 'associated' do
        it 'user' do
          expect(FactoryGirl.build_stubbed(:review, user: nil)).to be_invalid
        end

        it 'space' do
          expect(FactoryGirl.build_stubbed(:review, space: nil)).to be_invalid
        end
      end
    end

    context 'with evaluation' do
      it 'inferior to permitted' do
        expect(FactoryGirl.build_stubbed(:review, evaluation: 0)).not_to be_valid
      end

      it 'superior to permitted' do
        expect(FactoryGirl.build_stubbed(:review, evaluation: 6)).not_to be_valid
      end

      it 'being a float' do
        expect(FactoryGirl.build_stubbed(:review, evaluation: 2.1)).not_to be_valid
      end
    end
  end
end
