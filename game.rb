class Game
  def initialize
    @player
    @dealer = Dealer.new
    @deck
    @bank = Bank.new
    @interface = Interface.new
  end

  def start
    player_init
    game_session

  # rescue StandardError => e
  #   @interface.input_error(e)
  # retry
  end

  private

  def player_init
    @interface.ask_player_name
    name = @interface.answer_some_question
    @player = Player.new(name)
  end

  def game_session
    loop do
      start_game
      game_logic
      @interface.ask_continue_game
      continue = @interface.answer_some_question
      break if continue == "q"
    end
  end

  def show_cards(player)
    player.hand.player_cards.each { |card| @interface.show_card(card) }
  end

  def closed_cards(player)
    player.hand.player_cards.each { |card| @interface.show_closed_card }
  end

  def start_game
    @deck = Deck.new

    @player.hand.reset_game_info
    @dealer.hand.reset_game_info

    @player.hand.add_card(@deck.take_card)
    @player.hand.add_card(@deck.take_card)
    @dealer.hand.add_card(@deck.take_card)
    @dealer.hand.add_card(@deck.take_card)

    @interface.ask_take_bet
    @bank.take_bet(@player.bank.make_bet)
    @bank.take_bet(@dealer.bank.make_bet)

    @interface.show_your_card
    show_cards(@player)
    @interface.show_dealer_card
    closed_cards(@dealer)

    @player.hand.scoring
    @dealer.hand.scoring
    @interface.show_your_score(@player.hand.score)
  end

  def game_logic
    game_process
    @interface.show_your_card
    show_cards(@player)
    @interface.show_dealer_card
    show_cards(@dealer)
    @player.hand.scoring
    @dealer.hand.scoring
    @interface.show_your_score(@player.hand.score)
    @interface.show_dealer_score(@dealer.hand.score)
    show_result
  end

  def game_process
    until @player.hand.player_cards.length == 3 && @dealer.hand.player_cards.length == 3  do
      @interface.game_menu
      select = @interface.answer_some_question.to_i
      case select
      when 1
        dealer_move
      when 2
        player_take_card
      when 3
        break
      end
    end
  end

  def dealer_move
    @interface.dealer_move
    move = @dealer.dealer_game(@deck)
    if move == "pass"
      @interface.dealer_pass
    else
      @interface.dealer_take_card
      closed_cards(@dealer)
    end
  end

  def player_take_card
    if @player.hand.player_cards.length < 3
      @player.hand.add_card(@deck.take_card)
      @interface.show_your_card
      show_cards(@player)
      @player.hand.scoring
      @interface.show_your_score(@player.hand.score)
      dealer_move
    else
      @interface.warning_about_cards
    end
  end

  def result(player1, dealer)
    return player1 if dealer.hand.score > 21 && player1.hand.score <= 21 || player1.hand.score > dealer.hand.score && player1.hand.score <= 21
    return dealer if player1.hand.score > 21 || dealer.hand.score > player1.hand.score && player1.hand.score <= 21
    return "Ничья" if player1.hand.score == dealer.hand.score
  end

  def show_result
    result = result(@player, @dealer)
    if result == "Ничья"
      @interface.draw
      money = @bank.give_win
      @player.bank.take_win(money/2)
      @dealer.bank.take_win(money/2)
      @interface.balance(@player.bank.player_money)
      @interface.balance_dealer(@dealer.bank.player_money)
    else
      @interface.winner(result.name)
      result.bank.take_win(@bank.give_win)
      @interface.balance(@player.bank.player_money)
      @interface.balance_dealer(@dealer.bank.player_money)
    end
  end

end
