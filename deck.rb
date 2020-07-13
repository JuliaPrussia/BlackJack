class Deck
  attr_reader :deck

  def initialize
    @deck = []
    init_deck
    @deck.shuffle!
  end

  def take_card
    @deck.pop
  end

  private

  def init_deck
    Card::VALUES.each do |value|
      Card::SUITS.each {|suit| @deck.push(Card.new(suit, value))}
    end
  end

end
