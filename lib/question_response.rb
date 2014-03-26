class QuestionResponse < ActiveRecord::Base
  has_many :response_selections
  has_one :taker, through: :response_selections
  belongs_to :survey
  belongs_to :question
  belongs_to :response

  # def show_pair
  #   qr_pair = []
  #   qr_pair[0] = QuestionResponse.where(:id => self.id).joins(:question).pluck(:name).first
  #   qr_pair << QuestionResponse.where(:id => self.id).joins(:response).pluck(:name).first
  #   qr_pair
  # end
end
