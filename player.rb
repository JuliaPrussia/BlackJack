class Player
  attr_reader :name,
              :money,
              :hand

  NAME_TEMPLATE = /^[A-zА-я]{3,16}$/

  def initialize(name)
    @name = name
    @hand = Hand.new
    @bank = Bank.new
    validate!
  end

  def show_cards
    @hand.player_cards.each { |card| puts"#{card.value}#{card.suit}" }
  end

  protected

  def validate!
    raise "Минимальная длина имени - 3 символа, максимальная - 16" unless @name =~ NAME_TEMPLATE
  end
end
