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
# Takes an argument to filter students, creating a new array to be iterated
# over for printing
def filter(students, initial)
  specified = students.select { |student|
    student[:name].start_with?(initial) && student[:name].length < 12}
end

def print(results)
  count = 0
  while count < results.count
    results.each_with_index { |student, index|
      puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
      }
    count +=1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Takes user input to determine the letter to filter students by
def initial_choice
  puts "Please provide a first initial for us to filter your results: "
  initial = gets.chomp
end
# Nothing happens until we call methods
students = input_students
print_header
results = filter(students, initial_choice)
print(results)
print_footer(students)
