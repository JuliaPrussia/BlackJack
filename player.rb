class Player
  attr_reader :name,
              :money,
              :hand

  NAME_TEMPLATE = /^[A-zА-я]{3,16}$/

  def initialize(name)
    @name = name
    @money = 100
    @hand = Hand.new
    validate!
  end

  def make_bet
    @money -= 10
    return 10
  end

  def take_win(money)
    @money += money
  end

  def show_cards
    @hand.player_cards.each { |card| puts"#{card.value}#{card.suit}" }
  end

  protected

  def validate!
    raise "Минимальная длина имени - 3 символа, максимальная - 16" unless @name =~ NAME_TEMPLATE
  end
end
