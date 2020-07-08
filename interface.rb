class Interface
  def initialize
  end

  def show_card(card)
    puts"#{card.value}#{card.suit}"
  end

  def show_closed_card
    puts"*"
  end

  def ask_player_name
    puts "Введите желаемое имя:"
  end

  def answer_some_question
    gets.chomp
  end

  def ask_continue_game
    puts "Продолжаем играть?enter-продолжить, q - выход"
  end

  def ask_take_bet
    puts "Принимаем ставки в банк"
  end

  def show_your_card
    puts "Ваши карты:"
  end

  def show_dealer_card
    puts "Карты дилера:"
  end

  def show_your_score(score)
    puts "Ваш счет: #{score}"
  end

  def show_dealer_score(score)
    puts "Cчет дилера: #{score}"
  end

  def game_menu
    puts "Выберите действие:"
    puts "1.Пропустить ход"
    puts "2.Добавить карту"
    puts "3.Открыть карты(подсчет очков)"
  end

  def dealer_move
    puts "Право хода переходит к Дилеру"
  end

  def dealer_pass
    puts "Дилер пасует"
  end

  def dealer_take_card
    puts "Дилер берет карту"
  end

  def warning_about_cards
    puts"Взять новую карту возможно если у вас на руках только 2 карты!"
  end

  def draw
    puts "Ничья"
  end

  def balance(balance)
    puts "Ваш баланс: #{balance}"
  end

  def balance_dealer(balance)
    puts "Баланс Дилера: #{balance}"
  end

  def winner(name)
    puts "Победитель: #{name}"
  end

  def input_error(e)
    puts"#{e.message}"
    puts "попробуйте еще раз"
  end

end
