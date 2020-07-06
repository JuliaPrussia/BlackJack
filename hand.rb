class Hand
  attr_reader :player_cards,
              :score

  def initialize
    @player_cards = []
    @score = 0
  end

  def reset_game_info
    @player_cards = []
    @score = 0
  end

  def add_card(card)
    @player_cards.push(card)
  end

  def scoring
    @player_cards.each do |card|
      if card.score != 'A'
        @score += card.score
      end
    end

    @player_cards.each do |card|
      if card.score == 'A'
        @score +=1 if @score + 11 > 21
        @score +=11 if @score + 11 <= 21
      end
    end
  end

end
