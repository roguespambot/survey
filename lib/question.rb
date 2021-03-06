class Question < ActiveRecord::Base
  has_many :question_responses
  has_many :responses, through: :question_responses
  has_one :survey, through: :question_responses

  def get_responses
    Response.joins(question_responses: :question).where('question_responses.question_id' => self.id)
  end

  def count_others
    QuestionResponse.count(:user_response_id)
  end

  def percent_others

  end
end
