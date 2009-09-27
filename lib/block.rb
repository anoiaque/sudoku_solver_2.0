require "member.rb"  

class Block < Membre
  @index = 0
  @lines =[]
  @columns =[]
  
  
  def can_contain? number
    self.each_line   { |line|  return false if !line.can_contain? number }
    self.each_column { |col |  return false if !col.can_contain? number }
  end
  
  def each_line
   (1..3).each {|k| yield line(k)}
  end
  
  def each_column
   (1..3).each {|k| yield column(k)}
  end
  
  def each_element
    self.each_line{|l| l.each_element {|e| yield e}}
  end
  
  def line num
    @lines[num-1]
  end
  
  def column num
    @columns[num-1]
  end
  
  def initialize lines,columns,index
    @lines = lines
    @columns = columns
    @index = index
  end
end

