class Interface
  def initialize
    @player
    @dealer = Players.new("Dealer")
  end

  def start
    player_init
    puts "#{@player.name}"

    

    rescue StandardError => e
      puts "#{e.message}"
      puts "Попробуйте еще раз!"
    retry
  end

  def player_init
    puts "Введите желаемое имя:"
    name = gets.chomp
    @player = Players.new(name)
  end
end
