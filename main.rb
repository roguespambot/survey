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

def main_menu
  puts "Welcome to survey-bot 9000!"
  puts "Type 'new survey' to create a new survey. Type 'exit' to exit."
  print ">"
  choice = gets.chomp.downcase

  case choice
  when 'new survey'
    create_survey
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

main_menu
