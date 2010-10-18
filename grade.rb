class Grade
  attr :numeric 
  attr :str
  include Comparable
  
  def initialize(str)
    str.upcase =~ /([A-F])(\+|-)?/
    grade = $1 # A
    mod   = $2 # +

    num   = case grade
    when 'A'
      0.5
    when 'B'
      1.5
    when 'C'
      2.5
    when 'D'
      3.5
    when 'E'
      4.5
    when 'F'
      5.5
    else
      6.5
    end
    
    unless mod.nil?
      if mod == '+'
        num += -0.1
      else mod == '-'
        num += 0.1
      end
    end  
    
    @str     = str
    @numeric = num
  end
    
  def <=>(other)
    other.numeric <=> self.numeric
  end
  
  def to_s
    str
  end
end