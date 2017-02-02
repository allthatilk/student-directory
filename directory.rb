# Refactor notes: inline ifs, improve default values in methods without
# breaking loops. Very bad code smell with most of the looping and
# students_arr printing.

def interactive_menu
  students = []
  loop do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    selection = gets.chomp

    case selection
    when "1"
      students = input_student_info(input_cohort(input_name))
    when "2"
      print_header
      print_students(students)
      print_footer(students)
    when "9"
      exit # This will cause the program to terminate
    else
      puts "I don't know what you mean, try again"
    end
  # 3. Do what the user has asked
  end
end


def input_name(name = "J. Doe")
  puts "Please enter the name of the student."
  puts "To finish, just hit return twice."
  # Create an empty array
  students = []
  # Sets name variable to empty for while loop to work
  # While the name is not empty, repeat this code
  until name.empty? do
  # Get the first name
    name = gets.strip
    unless name.empty? == true
      puts "You have entered the name #{name}, is this correct? Y/N: "
      edit = gets.strip.downcase

        if edit == "y" or edit == "yes"
          puts "#{name}'s name has been registered."
        elsif edit == "n" or edit == "no"
          puts "Please enter the correct name: "
          name = gets.strip
        end
    end
    # If a name is entered it adds the name has to the students array and counts
    # the number of students entered so far
    case name.empty?
    when false
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
    cohort = gets.strip.to_sym

    unless cohort.empty? == true
      puts "You have entered cohort #{cohort}, is this correct? Y/N: "
      edit = gets.strip.downcase

        if edit == "y" or edit == "yes"
          student[:cohort] = cohort
          puts "#{student[:name]} has been registered to the #{cohort} cohort"
        elsif edit ==  "n" or edit == "no"
          puts "Please enter the correct cohort: "
          cohort = gets.strip
        end

    end

  end

  students
end

def input_student_info(students)
# Takes input and adds to each student's hash in array
  students.each do |student|
    puts "Please enter #{student[:name]}'s favourite hobby: "
    hobby = gets.strip
    student[:hobbies] = hobby
    puts "Please enter #{student[:name]}'s height: "
    height = gets.strip
    student[:heights] = height
    puts "What is #{student[:name]} most likely to be remembered for?"
    activity = gets.strip
    student[:most_likely_to] = activity

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
#def filter(students_arr, filter_by)
#  specified = students_arr.select { |student|
#    student[:name].start_with?(filter_by) && student[:name].length < 12}
#end
# Creates a tally and uses that as index for results array values to iterate
# through results to print
def print_students(results)
  tally = 0

  while tally < results.count
    index = results[tally]
     puts "#{tally + 1}. #{index[:name]}".center(70)
     puts "Favourite hobby: #{index[:hobbies]}".center(75)
     puts "Height: #{index[:heights]}".center(75)
     puts "Most likely to resort to #{index[:most_likely_to]}".center(75)
     puts "(#{index[:cohort]} cohort)".center(75)
     puts "\n"
    tally +=1
  end

end

#def print_by_cohort(students)
#  puts "Please select the cohort you wish to view: "
#  filter = gets.strip.to_sym

#  students.select { |student|
#    student[:cohort] == filter }.each_with_index {|student, index|
#      puts "This is the #{student[:cohort]} cohort: "
#      puts "#{index + 1}. #{student[:name]}".center(70)
#      puts "Favourite hobby: #{student[:hobbies]}".center(75)
#      puts "Height: #{student[:heights]}".center(75)
#      puts "Most likely to resort to #{student[:most_likely_to]}".center(75)
#      puts "\n"
#      }
#end

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
  filter_by = gets.strip
end
# Nothing happens until we call methods
interactive_menu
#students_arr = input_student_info(input_cohort(input_name))
#print_header
#print_by_cohort(students_arr)
#results = filter(students_arr, initial_choice)
#print_students(results)
#print_footer(students_arr)
