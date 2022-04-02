require 'rails_helper'

RSpec.describe IncrementalService, type: :model do
  it 'should #call successfully' do
    expect(IncrementalService.call.success?).to eq(true)
  end

  it 'should return idx successfully' do
    expect(IncrementalService.call.result).to eq(Incremental.first.idx)
  end
end
