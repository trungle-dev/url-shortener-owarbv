require 'rails_helper'

RSpec.describe ShortenerService, type: :model do
  describe 'should #call successfully' do
    context 'when all input are valid' do
      let(:url) { 'http://google.com' }
      it { expect(ShortenerService.call(url).success?).to eq(true) }
      it { expect(ShortenerService.call(url).result).to eq(UrlShortener.last) }
    end

    context 'when all input url are nil' do
      let(:url) { nil }
      it { expect { ShortenerService.call(url) }.to raise_error(Utils::JsonError) }
    end

    context 'when all input url are empty' do
      let(:url) { '' }
      it { expect { ShortenerService.call(url) }.to raise_error(Utils::JsonError) }
    end

    context 'when all input url are not valid' do
      let(:url) { 'invalidurl' }
      it { expect { ShortenerService.call(url) }.to raise_error(Utils::JsonError) }
    end
  end
end
