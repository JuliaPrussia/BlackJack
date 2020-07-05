class Interface
  def initialize
    @player
    @dealer
    @deck
    @bank = 0
  end

  def start
    player_init
    game

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

  def game
    loop do
      start_game
      game_logic
      puts "Продолжаем играть?enter-продолжить, q - выход"
      continue = gets.chomp
      break if continue == "q"
    end
  end

  def start_game
    @deck = CardDeck.new

    @player.reset_game_info
    @dealer.reset_game_info

    @player.add_card(@deck.take_card)
    @player.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)
    @dealer.add_card(@deck.take_card)

    puts "Принимаем ставки в банк"
    @bank += @player.bet + @dealer.bet

    puts "Ваши карты:"
    show_cards(@player)
    puts "Карты дилера:"
    closed_cards(@dealer)

    scoring(@player)
    scoring(@dealer)
    puts "Ваш счет: #{@player.score}"
  end

  def game_logic

    until @player.player_cards.length == 3 && @dealer.player_cards.length == 3  do
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
        break
      end
    end
    puts "Ваши карты:"
    show_cards(@player)
    puts "Карты дилера"
    show_cards(@dealer)
    puts "Ваш счет: #{@player.score}"
    puts "Cчет дилера: #{@dealer.score}"
    result = result(@player, @dealer)
    if result == "Ничья"
      puts "Ничья"
      @player.take_win(@bank/2)
      @dealer.take_win(@bank/2)
      @bank = 0
      puts "Ваш баланс #{@player.money}"
    else
      puts "Победитель: #{result.name}"
      result.take_win(@bank)
      @bank = 0
      puts "Ваш баланс #{@player.money}"
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

  def result(player1, player2)
    return player1 if player2.score > 21 && player1.score <= 21 || player1.score > player2.score && player1.score <= 21
    return player2 if player1.score > 21 && player2.score <= 21 || player2.score > player1.score && player2.score <= 21
    return "Ничья" if player1.score == player2.score || player1.score > 21 && player2.score > 21
  end

end
