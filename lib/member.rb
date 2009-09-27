class Membre
  
  def generate_doublons 
    doublons =[]
    change = false
     (1..9).each { |n| doublons += [n.can_only_be_in_two_elements?(self)]}
     (0..8).each {|n| doublons[n] = nil if doublons.count(doublons[n]) != 2}    
     (0..8).each do |n|
      next if doublons[n].nil?
      change = true
      doublons[n][0].doublon +=[n+1]
      doublons[n][0].doublon_link = doublons[n][1]
      doublons[n][1].doublon +=[n+1]
      doublons[n][1].doublon_link = doublons[n][0]
    end
    change
  end
  
  def solve_doublons
    
    self.each_element do |e|
      if e.doublon?
        if Membre.symetric_doublon? e
          dbl = e.doublon
          dbl_link = e.doublon_link
          e.set_with(dbl[0])
          dbl_link.set_with(dbl[1])
        else
          dbl1 = e.doublon[0]
          dbl2 = e.doublon[1]
          e_link = e.doublon_link
          if e.line.to_a.include?(dbl1)
            e.set_with(dbl2)
            e_link.set_with(dbl1)
          end
          if e.column.to_a.include?(dbl1)
            e.set_with(dbl2)
            e_link.set_with(dbl1)
          end
        end
      end
    end
  end
  
  # Cas où il y  a plusieurs solutions au sudoku (doublons correspondants sur deux lignes différentes)
  def self.symetric_doublon? elem
    same_on_line = false
    same_on_column = false
    elem.line.each_element {|e| same_on_line = true  if (e.doublon == elem.doublon)&& !(e.index == elem.index) }
    elem.column.each_element {|e| same_on_column = true  if (e.doublon == elem.doublon)&& !(e.index == elem.index) }
    same_on_column && same_on_line
  end
  
  def only_two_elements_can_contain? number
    p = []
    self.each_element { |e| p = p+[e] if number.can_be_in?(e)}
    p if  p.length==2
  end
  
  def can_contain? number
    self.each_element{ |e| return false if (e.value == number || contains_doublon_with?(number))}
  end
  
  def contains_doublon_with? number
    self.each_element {|e| return true if (e.doublon.include?(number) && self.contain?(e.doublon_link))}
    false
  end
  
  def each_element
    @value.each {|elem| yield elem}
  end
  
  def contain? elem
    return false if elem.nil?
    contain = false
    self.each_element {|e| return true if e.index == elem.index}
    contain
  end
  
  def to_a
    a = []
    @value.each {|elem| a = a +[elem.value]} 
    a
  end
end
