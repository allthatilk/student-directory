# Refactor notes: use inline ifs, improve default values in methods without
# breaking loops. Very bad code smell with most of the looping for input and
# students_arr printing.
@students = []

def try_load_students
  filename = ARGV.first # First argument from the command line
  return if filename.nil? # Get out of the method if it isn't given
  if File.exists?(filename) # If it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # If it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # Quit the program
  end
end

def interactive_menu
  loop do
      print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list of students to students.csv"
  puts "4. Load the list of students from students.csv"
  puts "5. Filter students by name"
  puts "6. Filter by cohort"
  puts "9. Exit" # 9 because we'll be adding more items
end

def process(selection)
  case selection
  when "1"
    input_all
  when "2"
      show_students
  when "3"
      save_students
  when "4"
    load_students
  when "5"
    filter_by_name
  when "9"
    exit # This will cause the program to terminate
  else
    puts "I don't know what you mean, try again"
  end
end
# Gets student name, checks it's correct, adds name hash to @students array
def input_name
  default = "J. Doe"
  # Take name as input
  puts "Please enter the name of the student: "
  name = STDIN.gets.chomp
  # Check name is correct
  puts "You have entered the name #{name}."
  # Give chance to correct (optional)
  name = yes_no(name)
  # Add as hash values to array
  name = is_it_empty(default, name)
  @students << {name: name}
  puts "Would you like to add another student? Y/N: "
  another_student = STDIN.gets.chomp.downcase
  input_name if another_student == "y"
  # Use this method inside another with other student input methods to get
  # a method that inputs and checks one student at a time rather than the
  # haphazard approach of old code
  #puts @students
end

def input_cohort
  default = "No"
  # Link cohort to correct student
  @students.each do |student|
  # Get cohort
  puts "Please enter the cohort for #{student[:name]}: "
  cohort = STDIN.gets.chomp.to_sym
  # Check cohort correct
  puts "You have allocated #{student[:name]} to the #{cohort} cohort"
  cohort = yes_no(cohort).to_sym
  cohort = is_it_empty(default, cohort)
  # Add cohort to existing hash in student array
  student[:cohort] = cohort
  end
  puts @students
end

def input_student_height
  default = "5f4in"
  @students.each do |student|
    puts "Please enter the height of #{student[:name]}: "
    height = STDIN.gets.strip
    puts "You have entered the height #{height} for student #{student[:name]}"
    height = yes_no(height)
    height = is_it_empty(default, height)
    student[:heights] = height
  end
  #puts @students
end

def input_student_hobby
  default = "murder"
  @students.each do |student|
    puts "Please enter the favourite hobby of #{student[:name]}: "
    hobby = STDIN.gets.strip
    puts "You have entered the hobby #{hobby} for #{student[:name]}"
    hobby = yes_no(hobby)
    hobby = is_it_empty(default, hobby)
    student[:hobbies] = hobby
  end
  #puts @students
end

def input_student_most_likely_to
  default = "go to jail"
  @students.each do |student|
    puts "What is #{student[:name]} most likely to be remembered for?"
    activity = STDIN.gets.strip
    puts "You have entered #{activity} for #{student[:name]}"
    activity = yes_no(activity)
    activity = is_it_empty(activity)
    student[:most_likely_to] = activity
  end
#  puts @students
end

def yes_no(value)
  puts "Is this correct? Y/N: "
  edit = STDIN.gets.chomp.downcase
  until edit == "y"
    puts "Please enter the correct value: "
    value = STDIN.gets.chomp
    puts "You have entered #{value}. Is this correct? Y/N: "
    edit = STDIN.gets.chomp.downcase
  end
    puts "Your input has been registered."
    value
end

def is_it_empty(default, value)
  value = default if value.empty? == true
  value
end

def input_all
  input_name
  input_cohort
  input_student_height
  input_student_hobby
  input_student_most_likely_to
  @students
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def save_students
  # Open the file for writing
  file = File.open("students.csv", "w")
  # Iterate ofer the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:hobbies], student[:heights], student[:most_likely_to]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename= "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, height, activity = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, hobbies: hobby, heights: height, most_likely_to: activity}
    end
  file.close
end

# Takes user input to filter students by name, creating a new array of selected
# students
def filter_name_input
  puts "Please provide a first initial for us to filter your results , or press ENTER again to skip: "
  initial_choice = gets.strip
specified = @students.select { |student|
    student[:name].start_with?(initial_choice) && student[:name].length < 12}
    specified
end
# Checks to see if the filter output will be empty, outputs default message if
# filter list is empty, otherwise prints filtered list
def print_filter(value)
  default = "\nThere are no students to display. Please select another option.\v"
  list = value
  list = is_it_empty(default, list)

    if list == default
      puts list
    else
      print_students_list(list)
  end
end

def filter_by_name
  print_filter(filter_name_input)
end

#def input_name(name = "J. Doe")
#  puts "Please enter the name of the student."
#  puts "To finish, just hit return twice."
  # Create an empty array
  # Sets name variable to empty for while loop to work
  # While the name is not empty, repeat this code
#  until name.empty? do
  # Get the first name
#    name = STDIN.gets.strip
#    unless name.empty? == true
#      puts "You have entered the name #{name}, is this correct? Y/N: "
#      edit = STDIN.gets.strip.downcase

#        if edit == /[yes]/ #"y" or edit == "yes"
#          puts "#{name}'s name has been registered."
#        elsif edit == /[no]/ #"n" or edit == "no"
#          puts "Please enter the correct name: "
#          name = STDIN.gets.strip
#        end
#    end
    # If a name is entered it adds the name has to the students array and counts
    # the number of students entered so far
#    @students << {name: name} if name.empty? == false
#      puts "Now we have #{@students.count} students"
#      puts "You can enter the name of another student or press ENTER to skip"

#  end
  # Return the array of students
#  @students
#end

#def input_cohort(cohort = "No")

#  @students.each do |student|
#    puts "Which cohort does #{student[:name]} belong to?"
#    cohort = STDIN.gets.strip.to_sym

#    unless cohort.empty? == true
#      puts "You have entered cohort #{cohort}, is this correct? Y/N: "
#      edit = STDIN.gets.strip.downcase

#        if edit == "y" or edit == "yes"
#          student[:cohort] = cohort
#          puts "#{student[:name]} has been registered to the #{cohort} cohort"
#        elsif edit ==  "n" or edit == "no"
#          puts "Please enter the correct cohort: "
#          cohort = STDIN.gets.strip
#        end

#    end

#  end

#  @students
#end

#def input_student_info(*)
# Takes input and adds to each student's hash in array
#  @students.each do |student|
#    puts "Please enter #{student[:name]}'s favourite hobby: "
#    hobby = STDIN.gets.strip
#    student[:hobbies] = hobby
#    puts "Please enter #{student[:name]}'s height: "
#    height = STDIN.gets.strip
#    student[:heights] = height
#    puts "What is #{student[:name]} most likely to be remembered for?"
#    activity = STDIN.gets.strip
#    student[:most_likely_to] = activity

#    puts "Now we have #{@students.count} students"
#  end
#  @students
#end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
# Takes user input to determine the letter to filter students by
#def initial_choice
#  puts "Please provide a first initial for us to filter your results , or press ENTER again to skip: "
#  filter_by = gets.strip
#end
# Creates a tally and uses that as index for results array values to iterate
# through results to print
def print_students_list(results)
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

def print_by_cohort(students)
  puts "Please select the cohort you wish to view: "
  filter = gets.strip.to_sym

  students.select { |student|
    student[:cohort] == filter }.each_with_index {|student, index|
      puts "This is the #{student[:cohort]} cohort: "
      puts "#{index + 1}. #{student[:name]}".center(70)
      puts "Favourite hobby: #{student[:hobbies]}".center(75)
      puts "Height: #{student[:heights]}".center(75)
      puts "Most likely to resort to #{student[:most_likely_to]}".center(75)
      puts "\n"
      }
end

def print_footer(names)

  if names.count == 0
    puts "We have no students at the moment"
  elsif names.count >0 and names.count < 2
    puts "Overall, we have #{names.count} great student"
  else
    puts "Overall, we have #{names.count} great students"
  end

end
# Nothing happens until we call methods
try_load_students
interactive_menu
#students_arr = input_student_info(input_cohort(input_name))
#print_header
#print_by_cohort(students_arr)
#results = filter(students_arr, initial_choice)
#print_students(results)
#print_footer(students_arr)
