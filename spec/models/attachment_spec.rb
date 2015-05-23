require 'rails_helper'

describe Attachment do
  after do
    @attachment.file_name.remove! unless @attachment.nil?
  end

  it 'has a valid factory' do
    @attachment = FactoryGirl.create(:attachment)
    expect(@attachment).to be_valid
  end
end
