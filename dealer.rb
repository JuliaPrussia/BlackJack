class Dealer < Player
  def initialize(name = "Dealer")
    super
    ## В таком варианте есть вариант изменения имени. Дабы избежать этого я вижу пару вариантов:
    ## 1) после вызова super принудительно изменить переменную @name(Но я считаю этот вариант крайне нелепым, что ли)
    ## 2) считать изменение имени ошибкой и отлавливать это
    ## Возможно,я не там искала, но вариантов избежать необходимость ввода параметров при наследовании,я не нашла.
  end

  def dealer_game(deck)
    if @hand.score < 17 && @hand.player_cards.length < 3
      @hand.add_card(deck.take_card)
      puts "Дилер берет карту"
      closed_cards
      @hand.scoring
    elsif @hand.score >= 17
      puts "Дилер пасует"
    end
  end

  def closed_cards
    @hand.player_cards.each { |card| puts"*" }
  end

end
