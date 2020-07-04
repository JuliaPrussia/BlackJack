class Players
  attr_reader :name,
              :money,
              :player_cards,
              :score

  NAME_TEMPLATE = /^[A-zА-я]{3,16}$/

  def initialize(name)
    @name = name
    @money = 100
    @player_cards = []
    @score = 0
    validate!
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

  protected

  def validate!
    raise "Минимальная длина имени - 3 символа, максимальная - 16" unless @name =~ NAME_TEMPLATE
  end
end
