class Player
  attr_reader :name,
              :money,
              :hand,
              :bank

  NAME_TEMPLATE = /^[A-zА-я]{3,16}$/

  def initialize(name)
    @name = name
    @hand = Hand.new
    @bank = Bank.new
    @interface = Interface.new
    validate!
  end

  protected

  def validate!
    raise "Минимальная длина имени - 3 символа, максимальная - 16" unless @name =~ NAME_TEMPLATE
  end
end
