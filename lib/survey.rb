class Survey < ActiveRecord::Base
  has_many :questions, through: :question_responses
  has_many :responses, through: :question_responses
end
