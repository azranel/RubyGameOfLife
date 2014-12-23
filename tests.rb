require 'minitest/autorun'
require './board'
require './cell'

# Tests for board.rb
class BoardTests < Minitest::Test
  def test_check_for_board_start_stance
    board = Board.new([0, 0], [0, 1], [1, 1])
    assert_equal board, Board.new([0, 0], [0, 1], [1, 1])
  end

  def test_check_if_cells_are_cell_class
    board = Board.new([0, 0], [0, 1], [1, 1])
    board.alive_cells.each do |cell|
      assert_equal Cell, cell.class
    end
  end

  def test_check_for_new_cells_after_born
    # given
    board = Board.new([0, 0], [0, 1], [1, 0])

    # when
    born = board.born

    # expect
    assert_equal [Cell.new([1, 1])], born
  end

  def test_check_for_cells_that_are_alive
    board = Board.new([0, 0], [0, 1], [1, 0])

    alive = board.alive

    assert_equal 3, alive.size
    assert_equal true, alive.include?(Cell.new([0, 0]))
    assert_equal true, alive.include?(Cell.new([1, 0]))
    assert_equal true, alive.include?(Cell.new([0, 1]))
  end

  def test_check_tick
    board = Board.new([0, 0], [0, 1], [1, 0], [4, 5])

    new_board = board.tick
    # puts new_board.alive_cells.to_s
    assert_equal false, new_board.include?(Cell.new([4, 5]))
    assert_equal true, new_board.include?(Cell.new([1, 1]))
  end
end

# Test for cell.rb
class CellTests < Minitest::Test
  def test_potential_neighbours
    cell = Cell.new([0, 0])
    neighbours = cell.potential_neighbours
    assert_equal 8, neighbours.size
  end
end
