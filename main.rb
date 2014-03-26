require 'active_record'
require './lib/survey'
require './lib/taker'
require './lib/response'
require './lib/response_selection'
require './lib/question'
require './lib/question_response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
    puts "Welcome to survey-bot 9000!"
end

def main_menu
  puts "Type 'new survey' to create a new survey."
  puts "Type 'list surveys' to list all surveys."
  puts "Type 'exit' to exit."
  print ">"
  choice = gets.chomp.downcase

  case choice
  when 'new survey'
    create_survey
  when 'list surveys'
    list_surveys
    survey_options
  when 'exit'
    puts "Goodbye!"
    exit
  else
    puts "I don't know what you were trying to do."
  end
end

def create_survey
  puts "What is this survey called?"
  print ">"
  survey_name = gets.chomp
  new_survey = Survey.create(:name => survey_name)
  user_input = nil
  until user_input == 'n'
    add_question(new_survey)
    puts "Would you like to add another question to '#{new_survey.name}'? (Y/N)"
    user_input = gets.chomp.downcase
  end
end

def add_question(survey)
  puts "What question would you like to ask?"
  print ">"
  question_name = gets.chomp
  new_question = Question.create(:name => question_name)
  user_input = nil
  until user_input == 'n'
    new_response = add_response(new_question)
    new_question_response = QuestionResponse.create(:question_id => new_question.id, :survey_id => survey.id, :response_id => new_response.id)
    puts "Would you like to add another response for '#{new_question.name}'? (Y/N)"
    user_input = gets.chomp.downcase
  end
end

def add_response(question)
  puts question.name
  puts "How can a user respond to this?"
  response = gets.chomp
  new_response = Response.create(:name => response)
end

def list_surveys
  Survey.all.each_with_index { |survey, index| puts "#{index+1}: #{survey.name}" }
end

def survey_options
  puts "Please enter the number of the survey you would like to take."
  puts "Type 'main' to return to the main menu."
  print ">"
  survey_num = gets.chomp
  if survey_num == 'main'
    main_menu
  else
    current_survey = Survey.all[survey_num.to_i-1]
    take_survey(current_survey)
  end
end

def take_survey(survey)
  question_ids = survey.get_question_ids
  question_ids.each_with_index do |question_id, index|
    system('clear')
    puts "Survey: #{survey.name}"
    puts "#{index + 1}. #{Question.find(question_id).name}"
    response_ids = Question.get_responses(question_id)
    response_ids.each_with_index do |response_id, index|
      puts "\t#{index + 1}. #{Response.find(response_id).name}"
    end
    puts "\n\nEnter the number of the response you would like to select."
    print ">"
    response_num = gets.chomp.to_i
    selected_response_id = response_ids[response_num-1]
    qr = QuestionResponse.find_by(:question_id => question_id, :response_id => selected_response_id, :survey_id => survey.id)
    survey_taker = Taker.create(:name => "Taker")
    new_response_selection = ResponseSelection.create(:taker_id => survey_taker.id, :question_response_id => qr.id)
  end
end

welcome
loop do
  main_menu
end
