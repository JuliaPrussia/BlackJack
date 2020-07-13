class Dealer < Player
  def initialize(*args)
    super('Dealer')
  end

  def dealer_game(deck)
    if @hand.score < 17 && @hand.player_cards.length < 3
      @hand.add_card(deck.take_card)
    else
      return "pass"
    end
  end

end
