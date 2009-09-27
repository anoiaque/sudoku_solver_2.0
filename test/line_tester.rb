require "test/unit"
require "sudoku.rb"
class LineTester < Test::Unit::TestCase
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
  
  def test_can_be_in_line
    assert !1.can_be_in?(@sudoku.line(1))
    assert 1.can_be_in?(@sudoku.line(5))
    @sudoku.element(45).value = 1;
    assert !1.can_be_in?(@sudoku.line(5))
  end
  
  def test_can_be_in_line_with_doublon
    assert 1.can_be_in?(@sudoku.line(2))
    @sudoku.element(12).doublon = [@sudoku.element(18),1,8];
    assert !1.can_be_in?(@sudoku.line(2))
  end
  
end