# OysterCard class
class OysterCard
  MAX_TOP_UP = 90
  MINIMUM_BALANCE = 1
  DEFAULT_BALANCE = 0
  MINIMUM_FARE = 2


  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
    @journey_tracker = false
  end

  def top_up(amount)
    raise "The maximum top up is £#{MAX_TOP_UP}" if max_reached?(amount)

    @balance += amount
  end

  def touch_in
    raise "£#{MINIMUM_BALANCE} is the minimum amount for single journey" unless @balance >= MINIMUM_BALANCE 
    @journey_tracker = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @journey_tracker = false
  end

  def in_journey?
    @journey_tracker
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
