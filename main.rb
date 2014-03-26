require 'active_record'
require './lib/survey'
require './lib/taker'
require './lib/response'
require './lib/response_selection'
require './lib/question'
require './lib/question_response'
require './lib/user_response'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
    system('clear')
    puts "Welcome to Survey-Bot 9000!"
end

def main_menu
  puts "\n\n\n"
  puts "Type 'new survey' to create a new survey."
  puts "Type 'survey menu' to take or score a survey."
  puts "Type 'exit' to exit."
  puts "\n\n"
  print ">"
  choice = gets.chomp.downcase

  case choice
  when 'new survey'
    create_survey
  when 'survey menu'
    survey_options
  when 'exit'
    puts "Goodbye!"
    exit
  else
    puts "I don't know what you were trying to do."
    puts "\n\n\n"
  end
end

def create_survey
  puts "\n\n\n"
  puts "What is this survey called?"
  print ">"
  survey_name = gets.chomp
  new_survey = Survey.create(:name => survey_name)
  user_input = nil
  until user_input == 'n'
    add_question(new_survey)
    puts "\n\n"
    puts "Would you like to add another question to '#{new_survey.name}'? (Y/N)"
    user_input = gets.chomp.downcase
  end
end

def add_question(survey)
  mc = false
  oe = false
  puts "\n\n"
  puts "What question would you like to ask?"
  print ">"
  question_name = gets.chomp
  puts "Is this question open-ended? (Y/N)"
  open_ended = gets.chomp
  if open_ended == 'n'
    puts "May a survey taker provide multiple responses to this question? (Y/N)"
    print ">"
    question_multiple_choice = gets.chomp.downcase

      if question_multiple_choice == 'y'
        mc = true
      end
    new_question = Question.create(:name => question_name, :multiple_choice? => mc)
    user_input = nil
    until user_input == 'n'
      new_response = add_response(new_question)
      new_question_response = QuestionResponse.create(:question_id => new_question.id, :survey_id => survey.id, :response_id => new_response.id)
      puts "\n\n"
      puts "Would you like to add another response for '#{new_question.name}'? (Y/N)"
      user_input = gets.chomp.downcase
    end
  else
    oe = true
    new_question = Question.create(:name => question_name, :multiple_choice? => mc, :open_ended? => oe)
    new_question_response = QuestionResponse.create(:question_id => new_question.id, :survey_id => survey.id)
  end
end

def add_response(question)
  puts question.name
  puts "\n\n"
  puts "How can a user respond to this?"
  response = gets.chomp
  new_response = Response.create(:name => response)
end

def list_surveys
  puts "\n"
  Survey.all.each_with_index { |survey, index| puts "#{index+1}: #{survey.name}" }
end

def survey_options
  puts "\n"
  puts "Would you like to 'take' a survey or 'score' a survey?"
  puts "\n"
  print ">"
  survey_choice = gets.chomp
  puts "\n"
  list_surveys
  puts "\n"
  puts "Please enter the number of the survey you would like to #{survey_choice}."
  puts "Type 'main' to return to the main menu."
  puts "\n"
  print ">"
  survey_num = gets.chomp
  if survey_num == 'main'
    main_menu
  else
    current_survey = Survey.all[survey_num.to_i-1]
  end
  if survey_choice == "take"
    take_survey(current_survey)
  elsif survey_choice == "score"
    score_survey(current_survey)
  else
    puts "No way."
  end
end

def score_survey(survey)
  Question.all.joins(:question_responses).where('question_responses.survey_id' => survey.id).uniq.each do |question|
    puts "#{question.name}"
    responses = question.get_responses
    responses.each_with_index do |response, index|
      qr = QuestionResponse.find_by(:question_id => question.id, :response_id => response.id, :survey_id => survey.id)
      puts "#{index+1}. #{response.name} - #{qr.counter} (#{qr.percent}%)"
    end
    puts "\n"
  end
end

def take_survey(survey)

  Question.all.joins(:question_responses).where('question_responses.survey_id' => survey.id).uniq.each do |question|
    system('clear')
    survey_taker = Taker.create(:name => "Taker")
    puts "#{question.name}"
    responses = question.get_responses
    if question.open_ended?
      print ">"
      response = gets.chomp
      new_response = Response.create(:name => response)
      new_qr = QuestionResponse.create(:question_id => question.id, :response_id => new_response.id, :survey_id => survey.id)
      new_response_selection = ResponseSelection.create(:taker_id => survey_taker.id, :question_response_id => new_qr.id)
    else
      responses.each_with_index do |response, index|
        puts "#{index+1}. #{response.name}"
          if !question.multiple_choice?
          puts "\n\nEnter the number of the response you would like to select."
          print ">"
          response_num = gets.chomp.to_i
          selected_response = responses[response_num-1]
          qr = QuestionResponse.find_by(:question_id => question.id, :response_id => selected_response.id, :survey_id => survey.id)
          new_response_selection = ResponseSelection.create(:taker_id => survey_taker.id, :question_response_id => qr.id)
        else
          puts "\n\nEnter the number(s) of the response(s) you would like to select (separate with spaces)."
          print ">"
          response_numbers = gets.chomp.split(" ")
          response_numbers.each do |response|
            selected_response = responses[response.to_i-1]
            qr = QuestionResponse.find_by(:question_id => question.id, :response_id => selected_response.id, :survey_id => survey.id)
            survey_taker = Taker.create(:name => "Taker")
            new_response_selection = ResponseSelection.create(:taker_id => survey_taker.id, :question_response_id => qr.id)
          end
        end
      end
    end
  end
end

welcome
loop do
  main_menu
end
