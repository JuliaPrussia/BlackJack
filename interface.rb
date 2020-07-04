class Interface
  def initialize
    @player
    @dealer
    @deck
  end

  def start
    player_init
    start_game

    # rescue StandardError => e
    #   puts "#{e.message}"
    #   puts "Попробуйте еще раз!"
    # retry
  end

  def player_init
    puts "Введите желаемое имя:"
    name = gets.chomp
    @player = Players.new(name)
    @dealer = Players.new("Dealer")

    @player.scoring
    puts "Счет #{@player.score}"
  end

  def start_game
    @deck = CardDeck.new

    @player.add_card(@deck.take_card)
    @player.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)

    show_cards

    @player.scoring
    puts "Ваш счет: #{@player.score}"
  end

  def show_cards
    puts"Ваши карты:"
    @player.player_cards.each { |card| puts"#{card.value}#{card.suit}" }
  end

end
