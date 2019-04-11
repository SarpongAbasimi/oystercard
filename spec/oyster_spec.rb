require 'oyster_card'

RSpec.describe OysterCard do
  let(:card) { described_class.new }
  let(:station) {double :Station }
  let(:exit_station) {double :ExitStation }

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

    it ' should return true if in journey' do
      card.top_up(10)
      card.touch_in(station)
      expect(card.in_journey?).to eq(true)
    end
  end

  describe 'touch in and touch out' do
    context '#touch_in' do
      it 'is expected to change in journey to true' do
        card.top_up(10)
        card.touch_in(station)
        expect(card).to be_in_journey
      end
      
      it 'should raise error if card has less than £1' do
        expect { card.touch_in(station) }.to raise_error '£1 is the minimum amount for single journey'
      end
      it 'stores the entry station' do
        card.top_up(10)
        card.touch_in(station)
        expect(card.entry_station).to eq(station)
      end
    end

   context '#touch_out' do
     it 'is expected to change in journey to false' do
       card.top_up(10)
       card.touch_in(station)
       card.touch_out(exit_station) 
       expect(card).not_to be_in_journey
     end
     it ' deducts fare from balance' do
       card.top_up(10)
       card.touch_in(station)
       fare = OysterCard::MINIMUM_FARE
       expect { card.touch_out(exit_station) }.to change { card.balance }.by(-fare)
     end
   end

  end
  describe '#journeyHistory' do
    let(:journey) { { 'entry_station' => station, 'exit_station' => exit_station } }
    it 'stores the entry and exit stations' do
      card.top_up(10)
      card.touch_in(station)
      card.touch_out(exit_station)
      expect(card.journey_history).to include(journey)
    end
  end
end
