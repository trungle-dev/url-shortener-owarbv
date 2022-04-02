require 'rails_helper'

RSpec.describe Incremental, type: :model do
  describe 'always valid' do
    subject { build :incremental }
    it { should be_valid }
  end

  describe 'self.get_new_idx' do
    it 'Should increase idx into 1 every call' do
      old_idx = Incremental.first&.idx || ENV['incremental_min_value']
      new_idx = Incremental.get_new_idx
      expect(new_idx).to eq(old_idx + 1)
      expect(Incremental.first.idx).to eq(new_idx)
    end
  end
end
