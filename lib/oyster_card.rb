class OysterCard

  MAX_TOP_UP = 90
  DEFAULT_BALACE = 0

  attr_reader :balance

  def initialize()
    @balance = DEFAULT_BALACE
  end

  def top_up(amount)
    fail "The maximum top of £#{ MAX_TOP_UP } has been reached" if max_reached?
    @balance += amount
  end

  private

  def max_reached?
    @balance >= MAX_TOP_UP
  end

end