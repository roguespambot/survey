require 'active_record'
require 'rspec'
require 'shoulda-matchers'
require './lib/question_response'
require './lib/question'
require './lib/response'
require './lib/response_selection'
require './lib/survey'
require './lib/taker'

database_configurations = YAML::load(File.open('./db/config.yml'))
test_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(test_configuration)

RSpec.configure do |config|
  config.after(:each) do
    QuestionResponse.all.each { |class_object| class_object.destroy }
    Question.all.each { |class_object| class_object.destroy }
    Response.all.each { |class_object| class_object.destroy }
    ResponseSelection.all.each { |class_object| class_object.destroy }
    Survey.all.each { |class_object| class_object.destroy }
    Taker.all.each { |class_object| class_object.destroy }
  end
end
