require "test/unit"
require "sudoku.rb"
require "element.rb"

class ElementTester < Test::Unit::TestCase
  
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
    
    @sudoku1 = Sudoku.new( [9,4,8,1,0,0,3,6,5,
                         6,2,5,8,3,9,1,4,7,
                         3,1,7,6,5,4,9,2,8,
                         5,0,2,0,1,0,6,0,4,
                         1,6,4,0,0,5,8,9,3,
                         0,0,9,0,0,0,7,0,2,
                         0,5,3,4,9,0,2,0,0,
                         4,7,1,3,2,6,5,8,9,
                         2,9,6,5,0,0,4,3,1])      
    
    
  end
  
  def create_doublon elems,doublon
    elems[0].doublon = elems[1].doublon = doublon
    elems[0].doublon_link = elems[1]  
    elems[1].doublon_link = elems[0]  
  end
  
  def test_value
    assert_equal 6,@sudoku.element(10).value
    assert @sudoku.element(1).empty?
    assert_equal 1,@sudoku.element(81).value
  end
  
  def test_doublon
    assert !@sudoku.element(8).doublon?
    @sudoku.element(8).doublon =[2,3]
    @sudoku.element(8).doublon_link = @sudoku.element(80)
    assert @sudoku.element(8).doublon?
  end
  
  def test_line_idx
    assert_equal 2,@sudoku.element(10).line_idx
    assert_equal 9,@sudoku.element(81).line_idx
  end 
  def test_index
    assert_equal 81,@sudoku.element(81).index
  end
  
  def test_column_idx
    assert_equal 1,@sudoku.element(10).column_idx
    assert_equal 9,@sudoku.element(81).column_idx
  end
  
  def test_block_idx
    assert_equal 1,@sudoku.element(3).block_idx
    assert_equal 9,@sudoku.element(81).block_idx
    assert_equal 5,@sudoku.element(31).block_idx
  end
  
  def test_can_only_be_in_element_block
    assert 1.can_only_be_in_element_block?(@sudoku.element(16))
    assert 2.can_only_be_in_element_block?(@sudoku.element(8))
    assert !1.can_only_be_in_element_block?(@sudoku.element(28))
    assert !2.can_only_be_in_element_block?(@sudoku.element(62))
  end
  
  def test_can_only_be_in_element_line
    assert 1.can_only_be_in_element_line?(@sudoku.element(16))
    assert !8.can_only_be_in_element_line?(@sudoku.element(18))
    assert 5.can_only_be_in_element_line?(@sudoku.element(70))
  end
  
  def test_can_only_be_in_element_column
    assert 2.can_only_be_in_element_column?(@sudoku.element(61))
    assert !2.can_only_be_in_element_column?(@sudoku.element(24))
  end
  
  def test_can_only_be_in
    assert 1.can_only_be_in?(@sudoku.element(16))
    assert  !3.can_only_be_in?(@sudoku.element(80))
    @sudoku.element(45).value = 3
    assert  3.can_only_be_in?(@sudoku.element(80))
  end
  
  def test_can_only_be_in_inside_doublon
    create_doublon [@sudoku1.element(62),@sudoku1.element(63)],[6,7]
    assert 7.can_only_be_in?(@sudoku1.element(62))
    assert 6.can_only_be_in?(@sudoku1.element(63))
    
    create_doublon [@sudoku1.element(35),@sudoku1.element(53)],[1,5]
    assert 5.can_only_be_in?(@sudoku1.element(35))
    assert 1.can_only_be_in?(@sudoku1.element(53))
  end
end







