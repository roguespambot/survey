require 'spec_helper'

describe QuestionResponse do
  it {should have_one :taker }

  # describe '#show_pair' do
  #   it 'returns an array of the question and response for a question_response object' do
  #     question1 = Question.create(:name => "What is coolest?")
  #     response1 = Response.create(:name => "Apples.")
  #     qr1 = QuestionResponse.create(:survey_id => 69, :question_id => question1.id, :response_id => response1.id)
  #     qr1.show_pair.should eq ["What is coolest?", "Apples."]
  #   end
  # end
end
