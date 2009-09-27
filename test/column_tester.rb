require "test/unit"
require "sudoku.rb"

class ColumnTester < Test::Unit::TestCase
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
  
  def test_can_be_in_column
    assert !6.can_be_in?(@sudoku.column(1))
    assert 3.can_be_in?(@sudoku.column(9))
    @sudoku.element(27).value = 3;
    assert !3.can_be_in?(@sudoku.column(9))
  end
  
  def test_can_be_in_column_with_doublon
    assert 1.can_be_in?(@sudoku.column(3))
    assert 2.can_be_in?(@sudoku.column(3))
    assert 5.can_be_in?(@sudoku.column(3))
    @sudoku.element(30).doublon = [@sudoku.element(18),2,5];
    assert !2.can_be_in?(@sudoku.column(3))
    assert !5.can_be_in?(@sudoku.column(3))
  end
  
end