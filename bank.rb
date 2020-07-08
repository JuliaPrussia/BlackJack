class Bank
  attr_reader :player_money

  INITIAL_MONEY = 100

  def initialize
    @money = 0
    @player_money = INITIAL_MONEY
  end

  def take_bet(bet)
    @money += bet
  end

  def give_win
    money = @money
    @money = 0
    money
  end

  def make_bet
    @player_money -= 10
    return 10
  end

  def take_win(money)
    @player_money += money
  end

end
