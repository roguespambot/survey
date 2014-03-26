class QuestionResponse < ActiveRecord::Base
  has_one :taker, through: :response_selections
end
