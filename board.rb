class Board
  attr_accessor :alive_cells

  def initialize(*cells)
    @alive_cells ||= []
    unless cells.nil?
      cells.each do |position|
        @alive_cells << Cell.new(position)
      end
    end
  end

  def ==(other)
    @alive_cells == other.alive_cells
  end

  def <<(cell)
    @alive_cells << cell
  end

  def tick
    board = Board.new
    (born + alive).each do |cell|
      board << cell
    end
    board
  end

  def tick!
    @alive_cells = born + alive
  end

  def include?(cell)
    @alive_cells.include?(cell)
  end

  # Returns Cells that are born in next tick
  def born
    neighbours = cells_neighbours
    h = count_neighbours(neighbours)
    born ||= []
    h.each do |k,v|
      born << Cell.new(k) if v==3
    end
    born
  end

  # Returns Cells that are still alive in next tick
  def alive
    neighbours = cells_neighbours
    neighbours = neighbours.map { |e| e if is_alive?(e) }
    neighbours.compact!
    h = count_neighbours(neighbours)
    alive ||= []
    h.each do |k,v|
      alive << Cell.new(k) if v==2 || v==3
    end
    alive
  end

  def cells_neighbours
    neighbours ||= []
    @alive_cells.each do |cell|
      neighbours << cell.potential_neighbours
      neighbours.flatten!
    end
    neighbours
  end

  def count_neighbours(neighbours)
    h = Hash.new
    neighbours.each do |cell|
      h[cell.to_a] = h[cell.to_a].nil? ? 1 : h[cell.to_a]+1
    end
    h
  end

  def is_alive?(cell)
    @alive_cells.include?(cell)
  end
end