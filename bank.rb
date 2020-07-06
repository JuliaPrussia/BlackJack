class Bank
  def initialize
    @money = 0
  end

  def take_bet(bet)
    @money += bet
  end

  def give_win
    return @money
    @money = 0
  end

end
