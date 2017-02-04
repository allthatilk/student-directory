# Refactor notes: used inline if for name input to make different kind of
# conditional looping. Changed the way the student input methods worked as the
# loops were unnecessary within method and very unweildy to refactor. Refactored
# filters to condense the code and simplify the methods. Refactored input methods
# so one method can create multiple key value pairs. Can't replace name or cohort
# input though due to name creating each student has and cohort value being a
# symbol.

@students = []
require 'csv'

def try_load_students
  filename = ARGV.first # First argument from the command line
  filename = "students.csv" if filename.nil?
  check_file(filename)
end

def check_file(filename)
  if File.exists?(filename) # If it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # If it doesn't exist
    puts "Sorry, the filename #{filename} doesn't exist."
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
  puts "3. Save the list of students to file"
  puts "4. Load the list of students from file"
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
    load_from_menu
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
  another_name
end

def another_name
  puts "Would you like to add another student? Y/N: "
  another_student = STDIN.gets.chomp.downcase
    if another_student == "y"
      input_name
    elsif another_student == "n"
      # Blank to break the method and continue inputs
    else
      another_name
  end
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

def input(key, default)
  @students.each do |student|
    puts "Please provide the #{key} of #{student[:name]}: "
    value = STDIN.gets.chomp
    value = checks(default, value)
    student[key.to_sym] = value
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
  value
end

def input_all
  input_name
  input_cohort
  input("height", "5f4in")
  input("hobby", "murder")
  input("key_feature", "go to jail")
  #@students
end

def show_students
  print_header
  print_students_list(@students)
  print_footer(@students)
end

def save_students
  puts "Please enter the name of the save file you wish to create: "
    filename = STDIN.gets.chomp
    headers = @students.first.keys
    CSV.open(filename, "w") do |csv|
      csv << headers
        @students.each do |student|
          csv << student.values
        end
    end
    puts "All student records saved to file: #{filename}"
end

#def load_students(filename)
#  File.open(filename, "r") do |file|
#  file.readlines.each do |line|
#    name, cohort, hobby, height, activity = line.chomp.split(',')
#      @students << {name: name, cohort: cohort.to_sym, hobby: hobby, height: height, key_feature: activity}
#    end
#  end
#  puts "Seleceted student records have been loaded."
#end

def load_students(filename)
  # Assigns all file data to variable, ignores headers in index and converts
  # headers to symbols
  data = CSV.foreach(filename, headers: true, header_converters: :symbol)
  data.each do |student|
    # Converts all cohort values to symbols
    student[:cohort] = student[:cohort].to_sym
    # Converts each student array to a hash and adds to the @students array
    @students << student.to_h
  end
  puts "Selected student records have been loaded."
end

def load_from_menu
  puts "Which file do you want to load?"
  filename = STDIN.gets.chomp
  check_file(filename)
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
    puts "Height: #{student[:height]}".center(75)
    puts "Favourite hobby: #{student[:hobby]}".center(75)
    puts "Their key feature is #{student[:key_feature]}".center(75)
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
