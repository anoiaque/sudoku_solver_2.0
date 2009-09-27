require "member.rb"  

class Line < Membre
  
  @index = 0 
  @value = [] 
  
  def initialize value,index 
    @value = value
    @index = index
  end
  
  
end