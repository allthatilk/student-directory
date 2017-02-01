def input_students
  puts "Please enter the profiles of the students"
  puts "To finish, just hit return twice"
  # Create an empty array
  students = []
  hobbies = []
  heights = []
  most_likely_to = []
  #cohort = []
  name = " "
  # While the name is not empty, repeat this code
  while !name.empty? do
  # Get the first name
    puts "Please enter the student's name: "
    name = gets.chomp

    if name.empty? == false
      puts "Please enter their favourite hobby: "
      hobby = gets.chomp
      puts "Please enter their height: "
      height = gets.chomp
      puts "What are they most likely to be remembered for?"
      activity = gets.chomp
      # Add the student hash to the array
      students << {name: name, hobbies: hobby, heights: height, most_likely_to: activity, cohort: :november}
      puts "Now we have #{students.count} students"
    end

  end
  # Return the array of students
  students
  #hobbies
  #heights
  #most_likely_to
end

def print_header
  puts "The students of Villians Academy"
  puts "-------------"
end
# Takes an argument to filter students, creating a new array to be iterated
# over for printing
def filter(students, filter_by)
  specified = students.select { |student|
    student[:name].start_with?(filter_by) && student[:name].length < 12}
end
# Creates a tally and uses that as index for results array values to iterate
# through results to print
def print(results)
  tally = 0
  while tally < results.count
    index = results[tally]
     puts "#{tally + 1}. #{index[:name]}\n\tFavourite hobby: #{index[:hobbies]}
     \tHeight: #{index[:heights]}\n\tMost likely to resort to #{index[:most_likely_to]}
      \t(#{index[:cohort]} cohort)"
    tally +=1
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end
# Takes user input to determine the letter to filter students by
def initial_choice
  puts "Please provide a first initial for us to filter your results , or press ENTER again to skip: "
  filter_by = gets.chomp
end
# Nothing happens until we call methods
students = input_students
print_header
results = filter(students, initial_choice)
print(results)
print_footer(students)
