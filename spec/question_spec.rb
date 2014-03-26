require 'spec_helper'

describe Question do
  it { should have_one :survey }

  describe '.get_responses' do
    it 'returns an array of responses for a provided question ID' do
      survey1 = Survey.create(:name => 'Cool Stuff')
      question1 = Question.create(:name => "What is coolest?")
      response1 = Response.create(:name => "Apples.")
      response2 = Response.create(:name => "Llamas.")
      question2 = Question.create(:name => "Where should I go on vacation?")
      response3 = Response.create(:name => "Iceland.")
      response4 = Response.create(:name => "Peru.")
      qr1 = QuestionResponse.create(:survey_id => survey1.id, :question_id => question1.id, :response_id => response1.id)
      qr2 = QuestionResponse.create(:survey_id => survey1.id, :question_id => question1.id, :response_id => response2.id)
      qr3 = QuestionResponse.create(:survey_id => survey1.id, :question_id => question2.id, :response_id => response3.id)
      qr4 = QuestionResponse.create(:survey_id => 47, :question_id => question2.id, :response_id => response4.id)
      question1.get_responses.should eq [response1, response2]
    end
  end
end
