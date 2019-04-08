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
      max_top_up = OysterCard::MAX_TOP_UP
      card.top_up(max_top_up)
      expect { card.top_up(1) }.to raise_error 'The maximum you can top up is £90 please'
    end
  end
end