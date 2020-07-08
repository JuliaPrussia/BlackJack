class Dealer < Player
  def initialize(*args)
    super('Dealer')
  end

  def dealer_game(deck)
    if @hand.score < 17 && @hand.player_cards.length < 3
      @hand.add_card(deck.take_card)
      @interface.dealer_take_card
      closed_cards
      @hand.scoring
    elsif @hand.score >= 17
      @interface.dealer_pass
    end
  end

  def closed_cards
    @hand.player_cards.each { |card| @interface.show_closed_card }
  end

end
