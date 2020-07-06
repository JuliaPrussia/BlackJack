class Game
  def initialize
    @player
    @dealer
    @deck
    @bank
    @interface = Interface.new
  end

  def start
    player_init
    game_session
  end

  private

  def player_init
    @interface.ask_player_name
    name = @interface.answer_some_question
    @player = Player.new(name)
    @dealer = Dealer.new
    @bank = Bank.new
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

  def start_game
    @deck = Deck.new

    @player.hand.reset_game_info
    @dealer.hand.reset_game_info

    @player.hand.add_card(@deck.take_card)
    @player.hand.add_card(@deck.take_card)
    @dealer.hand.add_card(@deck.take_card)
    @dealer.hand.add_card(@deck.take_card)

    @interface.ask_take_bet
    @bank.take_bet(@player.make_bet)
    @bank.take_bet(@dealer.make_bet)

    @interface.show_your_card
    @player.show_cards
    @interface.show_dealer_card
    @dealer.closed_cards

    @player.hand.scoring
    @dealer.hand.scoring
    @interface.show_your_score(@player.hand.score)
  end

  def game_logic
    until @player.hand.player_cards.length == 3 && @dealer.hand.player_cards.length == 3  do
      @interface.game_menu
      select = @interface.answer_some_question.to_i
      case select
      when 1
        @interface.dealer_move
        @dealer.dealer_game(@deck)
      when 2
        if @player.hand.player_cards.length < 3
          @player.hand.add_card(@deck.take_card)
          @interface.show_your_card
          @player.show_cards
          @player.hand.scoring
          @interface.show_your_score(@player.hand.score)
          @interface.dealer_move
          @dealer.dealer_game(@deck)
        else
          @interface.warning_about_cards
        end
      when 3
        break
      end
    end
      @interface.show_your_card
      @player.show_cards
      @interface.show_dealer_card
      @dealer.show_cards
      @interface.show_your_score(@player.hand.score)
      @interface.show_dealer_score(@dealer.hand.score)
      result = result(@player, @dealer)
      if result == "Ничья"
        @interface.draw
        money = @bank.give_win
        @player.take_win(money/2)
        @dealer.take_win(money/2)
        @interface.balance(@player.money)
        @interface.balance_dealer(@dealer.money)
      else
        @interface.winner(result.name)
        result.take_win(@bank.give_win)
        @interface.balance(@player.money)
        @interface.balance_dealer(@dealer.money)
      end
  end

  def result(player1, player2)
    return player1 if player2.hand.score > 21 && player1.hand.score <= 21 || player1.hand.score > player2.hand.score && player1.hand.score <= 21
    return player2 if player1.hand.score > 21 && player2.hand.score <= 21 || player2.hand.score > player1.hand.score && player2.hand.score <= 21
    return "Ничья" if player1.hand.score == player2.hand.score || player1.hand.score > 21 && player2.hand.score > 21
  end

end
