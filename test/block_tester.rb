require "test/unit"
require "sudoku.rb"
require "block.rb"

class BlockTester < Test::Unit::TestCase
  
  def setup
    @sudoku = Sudoku.new([0,0,8,1,0,0,3,0,5,
                         6,2,0,0,3,9,0,4,0,
                         0,1,7,2,5,0,0,0,0,
                         0,0,0,0,0,0,6,0,4,
                         0,0,0,0,0,0,0,9,0,
                         0,0,0,0,0,0,7,0,2,
                         0,5,3,4,9,0,0,0,0,
                         4,7,0,0,2,6,0,8,0,
                         0,0,6,5,0,0,4,0,1]) 
  end
  
  def test_get_block_lines_and_columns
    assert_equal [0,0,8],@sudoku.block(1).line(1).to_a
    assert_equal [0,8,0],@sudoku.block(9).line(2).to_a
    assert_equal [0,6,0],@sudoku.block(1).column(1).to_a
    assert_equal [0,0,0],@sudoku.block(5).column(2).to_a
    assert_equal [0,0,1],@sudoku.block(9).column(3).to_a
  end
  
  def test_can_contain
    assert !1.can_be_in?(@sudoku.block(1))
    assert !4.can_be_in?(@sudoku.block(9))
    assert 8.can_be_in?(@sudoku.block(2))
    assert 7.can_be_in?(@sudoku.block(8))
  end
  
  def test_can_contain_with_doublons_same_line
    assert 2.can_be_in?(@sudoku.block(9))
    @sudoku.element(70).doublon=[ @sudoku.element(72),6,2]
    @sudoku.element(72).doublon=[ @sudoku.element(70),6,2]
    assert !2.can_be_in?(@sudoku.block(9))
  end
  
  def test_can_contain_with_doublons_not_same_line_column
    assert 3.can_be_in?(@sudoku.block(4))
    @sudoku.element(28).doublon=[ @sudoku.element(47),3,8]
    @sudoku.element(47).doublon=[ @sudoku.element(28),3,8]
    assert !3.can_be_in?(@sudoku.block(4))
  end
  
end