class Taker < ActiveRecord::Base
  has_many :question_responses, through: :response_selections
end
