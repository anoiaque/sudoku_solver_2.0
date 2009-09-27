require "sudoku.rb"
require "member.rb"  

class Element < Membre
  @sudoku = nil;
  @index = 0;
  @line_idx= 0
  @column_idx = 0
  @block_idx = 0
  @value = 0
  @doublon = []
  @doublon_link = nil
  
  attr_accessor :value , :block_idx  , :line_idx,:column_idx,:doublon,:doublon_link,:index,:sudoku
  
  def can_only_contain? number,member=nil
    if member.nil?
      self.can_only_contain?(number,self.block) || self.can_only_contain?(number,self.line) || self. can_only_contain?(number,self.column) 
    else
      return false if !self.can_contain?number
      member.each_element { |e|  return false if (e.can_contain?(number) && (e.index != self.index))}
    end
  end
  
  def can_contain? number
    (self.empty? && (! self.doublon?))&& 
    number.can_be_in?(self.line)&&
    number.can_be_in?(self.column) &&
    number.can_be_in?(self.block)
  end
  
  def empty?
    self.value == 0 
  end
  
  def doublon?
    self.doublon.length == 2 && !@doublon_link.nil?
  end
  
  def set_with number
    self.value = number
    self.doublon = []
    self.doublon_link = nil
  end
  
  
  def block 
    @sudoku.block(@block_idx)
  end
  
  def line 
    @sudoku.line(@line_idx)
  end
  
  def column 
    @sudoku.column(@column_idx)
  end
  
  def initialize value,index,line_idx,col_idx,block_idx
    @index = index
    @value = value
    @line_idx = line_idx
    @column_idx = col_idx
    @block_idx = block_idx
    @doublon =[]
    @doublon_link = nil
  end
  
  
  
end