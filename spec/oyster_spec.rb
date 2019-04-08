require 'oyster_card'

RSpec.describe OysterCard do
  let(:card) { described_class.new }
  describe 'Described class' do
    it 'When initialized should have a balance of 0' do
      expect(card.balance).to eq(0)
    end
  end

  describe '#top_up' do 
    it 'allows users to top up' do
      expect{ card.top_up(10) }.to change{ card.balance }.by(10)
    end

    it ' should raise an error when max top up limit is reached' do
      90.times{ card.top_up(1) }
      expect { card.top_up(1) }.to raise_error 'The maximum top of £90 has been reached'
    end
  end
end