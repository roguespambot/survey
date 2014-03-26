require 'spec_helper'

describe QuestionResponse do
  it {should have_one :taker }

  describe '#percent' do
    it 'returns the percent of times a specific response was given to a question (compared to all responses to that question)' do
      question1 = Question.create(:name => "What is coolest?")
      response1 = Response.create(:name => "Apples.")
      response2 = Response.create(:name => "Llamas.")
      question2 = Question.create(:name => "Where should I go on vacation?")
      response3 = Response.create(:name => "Iceland.")
      response4 = Response.create(:name => "Peru.")
      qr1 = QuestionResponse.create(:survey_id => 203, :question_id => question1.id, :response_id => response1.id)
      qr2 = QuestionResponse.create(:survey_id => 203, :question_id => question1.id, :response_id => response2.id)
      rs1 = ResponseSelection.create(:taker_id => 22, :question_response_id => qr1.id)
      rs2 = ResponseSelection.create(:taker_id => 22, :question_response_id => qr1.id)
      rs3 = ResponseSelection.create(:taker_id => 22, :question_response_id => qr2.id)
      # rs4 = ResponseSelection.create(:taker_id => 22, :question_response_id => qr1.id)
      qr1.percent.should eq 67
    end

    it "doesn't break with 0" do
      question1 = Question.create(:name => "What is best in life?")
      response1 = Response.create(:name => "To see your enemies driven before you.")
      response2 = Response.create(:name => "Ice cream.")
      qr1 = QuestionResponse.create(:survey_id => 201, :question_id => question1.id, :response_id => response1.id)
      qr1.percent.should eq 0
    end
  end
end
