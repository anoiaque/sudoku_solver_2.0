require "element.rb"
require "block.rb"
require "line.rb"
require "column.rb"

class Fixnum
  def can_be_in? member
    member.can_contain? self
  end
  def can_only_be_in? element
    element.can_only_contain? self
  end
  def can_only_be_in_two_elements? member
    member.only_two_elements_can_contain? self
  end
  def can_only_be_in_element_block? element
    element.can_only_contain? self,element.block
  end
  def can_only_be_in_element_line? element
    element.can_only_contain? self,element.line
  end
  def can_only_be_in_element_column? element
    element.can_only_contain? self,element.column
  end
end

class Array
  def to_sudoku
    sudoku = Sudoku.new 
    sudoku.elements=to_elements self,sudoku
    sudoku.lines=to_lines sudoku
    sudoku.columns=to_columns sudoku
    sudoku.blocks=to_blocks sudoku
    sudoku
  end
  def count elem
    cpt = 0;
    self.each {|e| cpt+=1 if e == elem }
    cpt
  end
  
  private
  def to_blocks sudoku
    @blocks = Array.new
     (1..9).each do |b|
      num_first_line = (b-1).divmod(3)[0]*3 
      num_first_col = (b-1).divmod(3)[1]*3  
      block_lines = Array.new
      block_cols = Array.new
       (0..2).each do |k|
        block_lines[k] = Line.new(get_line(sudoku,num_first_line+k+1)[num_first_col..num_first_col+2],k+1)
        block_cols[k] = Column.new(get_column(sudoku,num_first_col+k+1)[num_first_line..num_first_line+2],k+1)
      end
      @blocks[b-1]= Block.new block_lines,block_cols,b
    end
    
    @blocks
  end
  
  def to_elements sudoku_array,sudoku
    @elements = Array.new
     (0..80).each do |k|
      num_line = k.divmod(9)[0]+1
      num_col =  k.divmod(9)[1]+1
      num_block = (num_line-1).divmod(3)[0]*3+(num_col-1).divmod(3)[0]+1
      @elements[k]= Element.new sudoku_array[k],k+1,num_line,num_col,num_block
      @elements[k].sudoku=sudoku
    end
    @elements
  end
  
  def to_lines sudoku
    @lines = Array.new
     (0..8).each {|k| @lines[k] = Line.new get_line(sudoku,k+1),k+1}
    @lines
  end
  def to_columns sudoku
    @columns = Array.new
     (0..8).each {|k| @columns[k] = Column.new get_column(sudoku,k+1),k+1}
    @columns
  end
  
  def get_column sudoku,num
    col = []
     (0..8).each do |k|
      col[k] = sudoku.element(num-1+k*9+1)
    end
    col
  end
  
  def get_line sudoku,num
    ligne =[]
     (0..8).each do |k| 
      ligne[k] = sudoku.element((num-1)*9+k+1)
    end
    ligne
  end
  
  
end
