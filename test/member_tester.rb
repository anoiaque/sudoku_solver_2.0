require "test/unit"
require "sudoku.rb"

class MemberTester < Test::Unit::TestCase
  
  
  
  def setup
    @sudoku = Sudoku.new([0,0,8,1,0,0,3,0,5,
                         6,2,0,0,3,9,0,4,0,
                         0,1,7,0,5,0,0,2,0,
                         0,0,0,0,0,0,6,0,4,
                         0,0,0,0,0,0,0,9,0,
                         0,0,0,0,0,0,7,0,2,
                         0,5,3,4,9,0,0,0,0,
                         4,7,0,0,0,6,0,8,0,
                         0,0,6,5,0,0,4,0,1])   
    
    @sudoku1=Sudoku.new([9,4,8,1,6,0,3,0,5,
                        6,2,5,0,3,9,1,4,0,
                        3,1,7,0,5,4,9,2,0,
                        5,0,2,0,1,3,6,0,4,
                        7,0,4,0,0,5,8,9,3,
                        1,0,9,0,4,0,7,0,2,
                        0,5,3,4,9,0,2,6,7,
                        4,7,1,3,2,6,5,8,9,
                        2,9,6,5,0,0,4,3,1])
    
    @sudoku2 = Sudoku.new([  9,4,8,1,7,2,3,6,5,
                          6,2,5,8,3,9,1,4,7,
                          3,1,7,6,5,4,9,2,8,
                          5,0,2,7,1,0,6,5,4,
                          1,6,4,2,6,5,8,9,3,
                          0,0,9,0,4,0,7,1,2,
                          8,5,3,4,9,1,2,7,6,
                          4,7,1,3,2,6,5,8,9,
                          2,9,6,5,8,7,4,3,1])
    
    @sudoku3 = Sudoku.new([  9,4,8,1,7,2,3,6,5,
                          6,2,5,8,3,9,1,4,7,
                          3,1,7,6,5,4,9,2,8,
                          0,0,2,7,1,0,6,0,4,
                          0,6,4,2,6,5,8,9,3,
                          0,0,9,0,4,0,7,0,2,
                          0,5,3,4,9,1,2,7,6,
                          4,7,1,3,2,6,5,8,9,
                          2,9,6,5,8,7,4,3,1])
    
  end
  
  def create_doublon elems,doublon
    elems[0].doublon = elems[1].doublon = doublon
    elems[0].doublon_link = elems[1]  
    elems[1].doublon_link = elems[0]  
  end
  
  def xtest_contain?
    assert @sudoku.line(5).contain?(@sudoku.element(45))  
    assert @sudoku.line(5).contain?(@sudoku.element(37)) 
    assert !@sudoku.line(6).contain?(@sudoku.element(37)) 
    assert @sudoku.column(6).contain?(@sudoku.element(78)) 
    assert !@sudoku.column(6).contain?(@sudoku.element(80)) 
    assert @sudoku.block(6).contain?(@sudoku.element(45)) 
    assert !@sudoku.block(6).contain?(@sudoku.element(33)) 
  end
  
  def xtest_contains_doublon_with_number_for_lines
    create_doublon([@sudoku.element(36), @sudoku.element(54)],[4,5])
    assert !@sudoku.line(4).contains_doublon_with?(4)
    assert !@sudoku.line(4).contains_doublon_with?(5)
    create_doublon([@sudoku.element(45), @sudoku.element(37)],[8,9])
    assert @sudoku.line(5).contains_doublon_with?(8)
    assert @sudoku.line(5).contains_doublon_with?(9)
  end
  
  def xtest_contains_doublon_with_number_for_blocks
    create_doublon([@sudoku.element(36), @sudoku.element(54)],[4,5])
    assert @sudoku.block(6).contains_doublon_with?(4)
    assert @sudoku.block(6).contains_doublon_with?(5)
    create_doublon([@sudoku.element(45), @sudoku.element(37)],[8,9])
    assert !@sudoku.block(6).contains_doublon_with?(8)
    assert !@sudoku.block(6).contains_doublon_with?(9)
  end
  
  def xtest_only_be_in_two_line_elements
    assert !2.can_only_be_in_two_elements?(@sudoku.line(5))
    assert_equal [@sudoku.element(5),@sudoku.element(6)],2.can_only_be_in_two_elements?(@sudoku.line(1))
    assert_equal [@sudoku.element(55),@sudoku.element(60)],8.can_only_be_in_two_elements?(@sudoku.line(7))
    assert_equal [@sudoku.element(55),@sudoku.element(60)],1.can_only_be_in_two_elements?(@sudoku.line(7))
  end
  
  def xtest_only_be_in_two_column_elements
    assert_equal [@sudoku.element(45),@sudoku.element(72)], 3.can_only_be_in_two_elements?(@sudoku.column(9))
    assert !3.can_only_be_in_two_elements?(@sudoku.column(8))
    create_doublon([@sudoku.element(45), @sudoku.element(80)],[8,9])
    assert_equal [@sudoku.element(35),@sudoku.element(53)],3.can_only_be_in_two_elements?(@sudoku.column(8))
  end
  
  def xtest_only_be_in_two_block_elements
    assert_equal [@sudoku.element(8),@sudoku.element(27)],6.can_only_be_in_two_elements?(@sudoku.block(3))
    assert !8.can_only_be_in_two_elements?(@sudoku.block(3))
    @sudoku.element(45).value = 8;
    assert_equal [@sudoku.element(16),@sudoku.element(25)],8.can_only_be_in_two_elements?(@sudoku.block(3))
    @sudoku.element(45).value = 0;
    create_doublon([@sudoku.element(45), @sudoku.element(72)],[8,9])
    assert_equal [@sudoku.element(16),@sudoku.element(25)],8.can_only_be_in_two_elements?(@sudoku.block(3))
  end
  
  def xtest_generate_doublons_for_lines
    @sudoku.line(7).generate_doublons
    assert_equal [1,8],@sudoku.element(55).doublon 
    assert_equal [1,8],@sudoku.element(60).doublon 
    assert_equal @sudoku.element(60),@sudoku.element(55).doublon_link
    assert_equal @sudoku.element(55),@sudoku.element(60).doublon_link
     (61..63).each {|k| assert !@sudoku.element(k).doublon?}  
  end
  
  def xtest_generate_doublons_for_columns
    @sudoku.column(8).generate_doublons
    assert_equal [1,5],@sudoku.element(35).doublon 
    assert_equal [1,5],@sudoku.element(53).doublon 
    assert_equal @sudoku.element(35),@sudoku.element(53).doublon_link
    assert_equal @sudoku.element(53),@sudoku.element(35).doublon_link
    assert !@sudoku.element(8).doublon?
    assert !@sudoku.element(62).doublon?
    assert !@sudoku.element(80).doublon?
  end
  
  def xtest_generate_doublons_for_blocks
    @sudoku.element(61).value = 2
    @sudoku.element(2).value = 9
    @sudoku.block(7).generate_doublons
    assert_equal [2,9],@sudoku.element(66).doublon 
    assert_equal [2,9],@sudoku.element(73).doublon 
    assert_equal @sudoku.element(66),@sudoku.element(73).doublon_link
    assert_equal @sudoku.element(73),@sudoku.element(66).doublon_link
  end
  
  def xtest_generate_doublon_with_same_doublon_on_line
    create_doublon [@sudoku.element(33),@sudoku.element(50)],[1,5]
    @sudoku.element(16).value = 1;
    @sudoku.element(70).value = 5;
    @sudoku.block(6).generate_doublons
    assert_equal [1,5],@sudoku.element(35).doublon 
    assert_equal [1,5],@sudoku.element(53).doublon 
    assert_equal @sudoku.element(35),@sudoku.element(53).doublon_link
    assert_equal @sudoku.element(53),@sudoku.element(35).doublon_link  
  end
  
  def test_generate_doublon_with_doublon_containing_number_on_same_line
    create_doublon [@sudoku3.element(55),@sudoku3.element(60)],[1,8]
    assert 5.can_only_be_in_two_elements?(@sudoku3.column(1))
    assert 8.can_only_be_in_two_elements?(@sudoku3.column(1))
    @sudoku3.column(1).generate_doublons
    assert_equal [5,8],@sudoku3.element(28).doublon 
    assert_equal [5,8],@sudoku3.element(46).doublon 
    assert_equal @sudoku3.element(28),@sudoku3.element(46).doublon_link
    assert_equal @sudoku3.element(46),@sudoku3.element(28).doublon_link    
  end
  
  def xtest_solve_doublons
    create_doublon [@sudoku1.element(13),@sudoku1.element(18)],[7,8]
    @sudoku1.each_line {|l| l.solve_doublons}
    assert_equal 8,@sudoku1.element(18).value
    assert_equal 7,@sudoku1.element(13).value
    create_doublon [@sudoku1.element(29),@sudoku1.element(47)],[3,8]
    @sudoku1.each_line {|l| l.solve_doublons}
    assert_equal 8,@sudoku1.element(29).value
    assert_equal 3,@sudoku1.element(47).value
  end
  
  #Test du cas où le sudoku a plusieurs solutions , doublons correspondants sur deux lignes différentes
  def xtest_multiple_choice
    create_doublon [@sudoku2.element(29),@sudoku2.element(33)],[3,8]
    create_doublon [@sudoku2.element(47),@sudoku2.element(51)],[3,8]
    assert Membre.symetric_doublon?(@sudoku2.element(29))
  end
  
end