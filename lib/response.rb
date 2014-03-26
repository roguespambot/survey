class Response < ActiveRecord::Base
  has_many :question_responses
  has_one :question, through: :question_responses
  has_one :survey, through: :question_responses
end
