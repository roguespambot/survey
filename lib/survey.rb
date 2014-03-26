class Survey < ActiveRecord::Base
  has_many :question_responses
  has_many :questions, through: :question_responses
  has_many :responses, through: :question_responses

  def get_question_ids
    question_ids = QuestionResponse.where(:survey_id => self.id).pluck(:question_id).uniq
  end
end
