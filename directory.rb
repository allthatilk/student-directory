# Refactor notes: used inline if for name input to make different kind of
# conditional looping. Changed the way the student input methods worked as the
# loops were unnecessary within method and very unweildy to refactor. Refactored
# filters to condense the code and simplify the methods. Refactored input methods
# a bit but still not happy. Will review.

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
  puts "5. Filter students by first name initial"
  puts "6. Filter by cohort"
  puts "9. Exit"
end

def process(selection)
  case selection
  when "1"
    puts "You have option 1 to input student data."
    input_all
  when "2"
    puts "You have selected option 2 to view all students on record."
    show_students
  when "3"
    puts "You have selected option 3 to save current students records."
    save_students
  when "4"
    puts "You have selected option 4 to load students records from file."
    load_students
  when "5"
    puts "You have selected option 5 to filter student records by first initial."
    filter_by_name
  when "6"
    puts "You have selected option 6 to filter student records by cohort."
    filter_by_cohort
  when "9"
    puts "Thank you for using this directory. Goodbye."
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
  checks(default, name)
  @students << {name: name}
  puts "Would you like to add another student? Y/N: "
  another_student = STDIN.gets.chomp.downcase
  input_name if another_student == "y"
end

def input_cohort
  default = "No"
  # Link cohort to correct student
  @students.each do |student|
  # Get cohort
  puts "Please enter the cohort for #{student[:name]}: "
  cohort = STDIN.gets.chomp.to_sym
  checks(default, cohort).to_sym
  # Add cohort to existing hash in student array
  student[:cohort] = cohort
  end
end

def input_student_height
  default = "5f4in"
  @students.each do |student|
    puts "Please enter the height of #{student[:name]}: "
    height = STDIN.gets.strip
    checks(default, height)
    student[:heights] = height
  end
end

def input_student_hobby
  default = "murder"
  @students.each do |student|
    puts "Please enter the favourite hobby of #{student[:name]}: "
    hobby = STDIN.gets.strip
    checks(default, hobby)
    student[:hobbies] = hobby
  end
end

def input_student_most_likely_to
  default = "go to jail"
  @students.each do |student|
    puts "What is #{student[:name]} most likely to be remembered for?"
    activity = STDIN.gets.strip
    checks(default, activity)
    student[:most_likely_to] = activity
  end
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

def checks(default, value)
  puts "You have entered #{value}"
  value = yes_no(value)
  value = is_it_empty(default, value)
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
  puts "All student records saved to file: students.csv"
end

def load_students(filename= "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, hobby, height, activity = line.chomp.split(',')
      @students << {name: name, cohort: cohort.to_sym, hobbies: hobby, heights: height, most_likely_to: activity}
    end
  file.close
  puts "Student records have been loaded."
end

# Takes user input to filter students by name, creating a new array of selected
# students
def filter_by_name
  puts "Please provide a first name initial for us to filter your results,"
  puts "or press ENTER to view all students: "
  letter_choice = gets.strip
specified = @students.select { |student|
    student[:name].start_with?(letter_choice)} #&& student[:name].length < 12}
    print_filter(specified)
end

def filter_by_cohort
  puts "Please select the cohort you wish to view: "
  filter = gets.strip.to_sym
  specified = @students.select { |student|
    student[:cohort] == filter }
      print_filter(specified)
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

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list(list)
  list.each_with_index do |student, index|
    puts "#{index + 1}. #{student[:name]}".center(70)
    puts "Favourite hobby: #{student[:hobbies]}".center(75)
    puts "Height: #{student[:heights]}".center(75)
    puts "Most likely to resort to #{student[:most_likely_to]}".center(75)
    puts "(#{student[:cohort]} cohort)".center(75)
    puts "\n"
  end
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

try_load_students
interactive_menu
