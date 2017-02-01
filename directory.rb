def input_students
  puts "Please enter the profiles of the students"
  puts "To finish, just hit return twice"
  # Create an empty array
  students = []
  # Sets name variable to empty for while loop to work
  name = " "
  # While the name is empty, repeat this code
  while !name.empty? do
  # Get the first name
    puts "Please enter the student's name: "
    name = gets.chomp
    # If a name is entered it loops for more info to add to the student hash
    if name.empty? == false
      puts "Please enter their favourite hobby: "
      hobby = gets.chomp
      puts "Please enter their height: "
      height = gets.chomp
      puts "What are they most likely to be remembered for?"
      activity = gets.chomp
      puts "Which cohort do they belong to?"
      cohort = gets.chomp
      # Add the student hash to the array
      students << {name: name, hobbies: hobby, heights: height, most_likely_to: activity, cohort: cohort}
      puts "Now we have #{students.count} students"
    end

  end
  # Return the array of students
  students
end

def print_header
  puts "The students of Villains Academy"
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
     puts "#{tally + 1}. #{index[:name]}".center(70)
     puts "Favourite hobby: #{index[:hobbies]}".center(75)
     puts "Height: #{index[:heights]}".center(75)
     puts "Most likely to resort to #{index[:most_likely_to]}".center(75)
     puts "(#{index[:cohort]} cohort)".center(75)
    tally +=1
  end

end

def print_footer(names)

  if names.count < 2
    puts "Overall, we have #{names.count} great student"
  else
    puts "Overall, we have #{names.count} great students"
  end

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
