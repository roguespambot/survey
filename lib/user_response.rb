class UserResponse < ActiveRecord::Base
  has_one :response_selection, through: :question_response
  has_one :question, through: :question_response

end
