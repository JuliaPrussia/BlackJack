class Interface
  def initialize
    @player
    @dealer = Players.new("Dealer")
    @deck = CardDeck.new
  end

  def start
    player_init

    # rescue StandardError => e
    #   puts "#{e.message}"
    #   puts "Попробуйте еще раз!"
    # retry
  end

  def player_init
    puts "Введите желаемое имя:"
    name = gets.chomp
    @player = Players.new(name)
    @player.add_card(@deck.take_card)
    @player.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)

    puts "#{@player.player_cards}"
    puts "#{@dealer.player_cards}"
  end
end
