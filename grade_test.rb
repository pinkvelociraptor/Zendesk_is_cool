require 'grade'

a = Grade.new("A")
["A+", "B", "C-", "F+", "G"].each do |letter|
  grade = Grade.new(letter)
  puts "#{grade} is #{grade.numeric}"
  if grade > a
    puts "#{grade} is greater than A"
  else
    puts "#{grade} is less than or equal to A"
  end
end

puts ["A", "B", "G", "C-", "A+", "C", "A-"].map { |m| Grade.new(m) }.sort.join(", ")

  