class Ship
  attr_reader :name, :length, :health, :sunk

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def sunk?
    return true if @health == 0
    false
  end

  def hit
    @health -= 1
  end

end
