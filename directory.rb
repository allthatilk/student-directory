def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # Create an empty array
  students = []
  # Get the first name
  name = gets.chomp
  # While the name is not empty, repeat this code
  while !name.empty? do
    # Add the student hash to the array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    # Get another name from the user
    name = gets.chomp
  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end

def print(students)
  # Iterates over hash value inside array to give student name and index value
  # in the array. Then prints the value +1 to account for cardinal number
  # counting.
  students.each_with_index { |student, index|
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
  }
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Nothing happens until we call methods
students = input_students
print_header
print(students)
print_footer(students)
