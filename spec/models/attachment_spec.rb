require 'rails_helper'

describe Attachment do
  after do
    @attachment.file_name.remove! unless @attachment.nil?
  end

  it 'has a valid factory' do
    @attachment = FactoryGirl.create(:attachment)
    expect(@attachment).to be_valid
  end

  describe 'is invalid' do
    context 'without' do
      context 'associated' do
        it 'file name' do
          @attachment = FactoryGirl.build_stubbed(:attachment, file_name: nil)
          expect(@attachment).to be_invalid
        end

        it 'space' do
          @attachment = FactoryGirl.build_stubbed(:attachment, space: nil)
          expect(@attachment).to be_invalid
        end
      end
    end
  end
end
