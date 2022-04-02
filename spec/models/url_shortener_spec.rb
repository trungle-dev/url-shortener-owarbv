require 'rails_helper'

RSpec.describe UrlShortener, type: :model do
  describe 'validations source_url field' do
    subject { build :url_shortener }

    it { should be_valid }

    it { should validate_presence_of(:source_url) }

    it 'Should validate correct format of source_url' do
      subject.source_url = 'invalid_url'
      expect(subject.valid?).to eq(false)
      expect(subject.errors.messages[:source_url]).to eq(['is invalid'])
    end
  end
end
