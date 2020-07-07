class Dealer < Player
  def initialize(_name)
    super('Dealer') ##при такои варианте вылетает ошибка о неверном кол-ве аргмуентов
    @interface = Interface.new
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
    @hand.player_cards.each { |card| puts"*" }
  end

end
