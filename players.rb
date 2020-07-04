class Players
  attr_reader :name,
              :money,
              :player_cards,
              :point

  NAME_TEMPLATE = /^[A-zА-я]{3,16}$/

  def initialize(name)
    @name = name
    @money = 100
    @player_cards = {}
    @points = 0
    validate!
  end

  protected

  def validate!
    raise "Минимальная длина имени - 3 символа, максимальная - 16" unless @name =~ NAME_TEMPLATE
  end
end
