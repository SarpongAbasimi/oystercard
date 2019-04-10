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
      expect { card.top_up(10) }.to change { card.balance }.by(10)
    end

    it ' should raise an error when max top up limit is reached' do
      max_top_up = OysterCard::MAX_TOP_UP
      card.top_up(max_top_up)
      expect { card.top_up(1) }.to raise_error 'The maximum top up is £90'
    end
  end
=begin
  describe '#deducts' do
    it 'decducts and amount from balance' do
      expect { card.deduct(10) }.to change { card.balance }.by(-10)
    end
  end
=end
  describe '#in_journey?' do
    it 'should return false' do
      expect(card).not_to be_in_journey
    end
  end

  describe 'touch in and touch out' do
    context '#touch_in' do
      it 'is expected to change in journey to true' do
        card.top_up(10)
        card.touch_in
        expect(card).to be_in_journey
      end
      it 'should raise error if card has less than £1' do
        expect { card.touch_in }.to raise_error '£1 is the minimum amount for single journey'
      end
    end

   context '#touch_out' do
     it 'is expected to change in journey to false' do
       card.touch_out 
       expect(card).not_to be_in_journey
     end
     it ' deducts fare from balance' do
       fare = OysterCard::MINIMUM_FARE
       expect {card.touch_out}.to change {card.balance}.by(-fare)
     end
   end
  end
end
