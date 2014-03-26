class Question < ActiveRecord::Base

  has_one :survey, through: :question_responses

end
