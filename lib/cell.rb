class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @empty = false
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !@ship.nil?
      @ship.hit
    end
    @fired_upon = true
  end

  def render(reveal = false)
    return "S" if (reveal && !@fired_upon && !@ship.nil?)
    return "." if !@fired_upon
    return "M" if @ship.nil? && @fired_upon
    return "X" if @ship.sunk?
    return "H" if @fired_upon
  end


end
