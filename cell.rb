# Represents living cell
class Cell
  attr_accessor :x, :y

  def initialize(position)
    fail ArgumentError unless position.is_a? Array
    @x, @y = position[0], position[1]
  end

  def potential_neighbours
    neighbours = []
    [-1, 0, 1].each do |ox|
      [-1, 0, 1].each do |oy|
        neighbours << Cell.new([@x + ox, @y + oy]) unless ox == 0 && oy == 0
      end
    end
    neighbours
  end

  def to_a
    [@x, @y]
  end

  # Should fix hash and == method so objects
  # can be used as keys in hash

  def ==(other)
    x == other.x && y == other.y
  end
end
