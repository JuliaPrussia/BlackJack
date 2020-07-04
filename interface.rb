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
  end

  def start_game
    @deck = CardDeck.new

    @player.add_card(@deck.take_card)
    @player.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)

    puts "Ваши карты:"
    show_cards(@player)
    puts "Карты дилера:"
    closed_cards(@dealer)

    scoring(@player)
    scoring(@dealer)
    puts "Ваш счет: #{@player.score}"

    loop do
      game_menu

      select = gets.chomp.to_i
      case select
      when 1
        puts "Право хода переходит к Дилеру"
        dealer_game(@dealer, @deck)
      when 2
        if @player.player_cards.length < 3
          @player.add_card(@deck.take_card)
          puts "Ваши карты:"
          show_cards(@player)
          scoring(@player)
          puts "Ваш счет: #{@player.score}"
          puts "Право хода переходит к Дилеру"
          dealer_game(@dealer, @deck)
        else
          puts"Взять новую карту возможно если у вас на руках только 2 карты!"
        end
      when 3
        puts "Ваши карты:"
        show_cards(@player)
        puts "Ваш счет: #{@player.score}"
        puts "Карты дилера"
        show_cards(@dealer)
        puts "Cчет дилера: #{@dealer.score}"
        break
      end
    end
  end

  def show_cards(player)
    player.player_cards.each { |card| puts"#{card.value}#{card.suit}" }
  end

  def closed_cards(player)
    player.player_cards.each { |card| puts"*" }
  end

  def scoring(player)
    player.scoring
  end

  def game_menu
    puts "Выберите действие:"
    puts "1.Пропустить ход"
    puts "2.Добавить карту"
    puts "3.Открыть карты(подсчет очков)"
  end

  def dealer_game(player, deck)
    if player.score < 17 && player.player_cards.length < 3
      player.add_card(deck.take_card)
      puts "Дилер берет карту"
      closed_cards(player)
      scoring(player)
    elsif player.score >= 17
      puts "Дилер пасует"
    end
  end

end
