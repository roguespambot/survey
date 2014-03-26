require 'spec_helper'

describe Survey do
  it { should have_many :questions }
  it { should have_many :responses }

  describe '#get_question_responses' do
    it 'returns an array of question and response pairs for that survey' do
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
      survey1.get_question_ids.should eq [question1.id, question2.id]
    end
  end
end
