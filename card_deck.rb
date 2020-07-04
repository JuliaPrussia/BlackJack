class CardDeck
  attr_reader :deck

  SUITS = ['♣', '♠', '♦', '♥']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']


  def initialize
    @deck = []
    init_deck
  end

  def init_deck
    VALUES.each do |value|
      SUITS.each {|suit| @deck.push(Card.new(suit, value))}
    end
  end

  def take_card
    @deck.sample
  end
end
