class Question < ActiveRecord::Base
  has_many :question_responses
  has_many :responses, through: :question_responses
  has_one :survey, through: :question_responses

  def self.get_responses(q_id)
    QuestionResponse.where(:question_id => q_id).joins(:response).pluck(:id)
  end
end
