require 'station'


RSpec.describe Station do
  let(:station) {described_class.new('victoria', 1)}

  it 'should have a name on creation' do
    expect(station.name).to eq('victoria')
  end

  it 'should have a zone on creation' do
    expect(station.zone).to eq(1)
  end
end