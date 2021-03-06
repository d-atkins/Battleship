require_relative 'color_palette'

class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    @ship.hit if !@ship.nil?
  end

  def render(reveal = false)
    return $S if (reveal && !@fired_upon && !@ship.nil?)
    return "." if !@fired_upon
    return $M if @ship.nil? && @fired_upon
    return $X if @ship.sunk?
    return $H if @fired_upon
  end

end
