def input_name(name = "J. Doe")
  puts "Please enter the name of the student."
  puts "To finish, just hit return twice."
  # Create an empty array
  students = []
  # Sets name variable to empty for while loop to work
  # While the name is not empty, repeat this code
  until name.empty? do
  # Get the first name
    name = gets.chomp
    # If a name is entered it adds the name has to the students array and counts
    # the number of students entered so far
    if name.empty? == false
      students << {name: name}
      puts "Now we have #{students.count} students"
      puts "You can enter the name of another student or press ENTER to skip"
    end

  end
  # Return the array of students
  students
end

def input_cohort(students, cohort = "No")

  students.each do |student|
    puts "Which cohort does #{student[:name]} belong to?"
    cohort = gets.chomp.to_sym
    students.map { |student| student[:cohort] = cohort}
  end

  students
end

def input_student_info(students)

  students.each do |student|
    puts "Please enter #{student[:name]}'s favourite hobby: "
    hobby = gets.chomp
    puts "Please enter #{student[:name]}'s height: "
    height = gets.chomp
    puts "What is #{student[:name]} most likely to be remembered for?"
    activity = gets.chomp
    # Add the student hash to the array
    students.map { |student| student[:hobbies] = hobby; student[:heights] = height; student[:most_likely_to] = activity}
    puts "Now we have #{students.count} students"
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
# Takes an argument to filter students, creating a new array to be iterated
# over for printing
def filter(students_arr, filter_by)
  specified = students_arr.select { |student|
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
students_arr = input_student_info(input_cohort(input_name))
print_header
results = filter(students_arr, initial_choice)
print(results)
print_footer(students_arr)
