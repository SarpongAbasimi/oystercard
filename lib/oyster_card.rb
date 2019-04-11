# OysterCard class
class OysterCard
  MAX_TOP_UP = 90
  MINIMUM_BALANCE = 1
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 2


  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_tracker = false
    @journey_history = []
  end

  def top_up(amount)
    raise "The maximum top up is £#{MAX_TOP_UP}" if max_reached?(amount)

    @balance += amount
  end

  def touch_in(station)
    raise "£#{MINIMUM_BALANCE} is the minimum amount for single journey" unless @balance >= MINIMUM_BALANCE
    @entry_station = station
    @journey = {}
    @journey['entry_station'] = station
    @journey_tracker = true
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @journey['exit_station'] = station
    @journey_history.push(@journey)
    @journey_tracker = false
  end

  def in_journey?
    !!entry_station
  end

  private

  def max_reached?(amount)
    user_top_up = @balance + amount
    user_top_up > MAX_TOP_UP
  end

  def deduct(amount)
    @balance -= amount
  end
end
