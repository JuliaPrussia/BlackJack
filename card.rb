class Card
  attr_reader :suit,
              :value

  def initialize (suit, value)
    @suit = suit
    @value = value
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

end
