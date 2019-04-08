class OysterCard

  MAX_TOP_UP = 90
  DEFAULT_BALACE = 0

  attr_reader :balance

  def initialize()
    @balance = DEFAULT_BALACE
  end

  def top_up(amount)
    fail "The maximum you can top up is £#{ MAX_TOP_UP } please" if max_reached?(amount)
    @balance += amount
  end

  private

  def max_reached?(amount)
    user_top_up = @balance + amount
    user_top_up > MAX_TOP_UP
  end

end