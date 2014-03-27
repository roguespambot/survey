class UserResponse < ActiveRecord::Base
  has_one :question_response
  has_one :question, through: :question_response
end
