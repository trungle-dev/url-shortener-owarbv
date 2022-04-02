require 'rails_helper'

RSpec.describe EncoderService, type: :model do
  context 'When number is 0' do
    it 'should return first value in the secret charset' do
      expect(EncoderService.call(0).result).to eq(ENV['secret_charset'][0])
    end
  end

  context 'When number is greater than 0' do
    it 'should return proper value' do
      expect(EncoderService.call(1).result).to eq(ENV['secret_charset'][1])
      expect(EncoderService.call(61).result).to eq(ENV['secret_charset'][-1])
      expect(EncoderService.call(62).result).to eq(ENV['secret_charset'][0..1].reverse)
    end
  end
end
