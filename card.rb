class Card
  attr_reader :suit,
              :value

  SUITS = ['♣', '♠', '♦', '♥'].freeze
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].freeze

  def initialize (suit, value)
    @suit = suit
    @value = value
    validate!
  end

  def score
    if @value.to_i > 0
      @value.to_i
    elsif @value == 'A'
      @value
    else
      10
    end
  end

  protected

  def validate!
    raise 'Ошибка такой масти не может быть у карты' unless SUITS.include? @suit
    raise 'Ошибка такого значения не может быть у карты' unless VALUES.include? @value
  end

end
