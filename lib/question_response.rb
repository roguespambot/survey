class QuestionResponse < ActiveRecord::Base
  has_many :response_selections
  has_one :taker, through: :response_selections
  belongs_to :survey
  belongs_to :question
  belongs_to :response

  def counter
    ResponseSelection.where(:question_response_id => self.id).count(:id)
  end

  def percent
    total = ResponseSelection.joins(:question_response).where('question_responses.question_id' => self.question_id).count(:id).to_f
    count = self.counter.to_f
    if total == 0
      percent = 0
    else
      percent = ((count/total)*100).round
    end
  end
end
