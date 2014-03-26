class ChangeTableNameToQuestionResponses < ActiveRecord::Migration
  def change
    drop_table :questions_responses
    create_table :question_responses do |t|
      t.column :question_id, :int
      t.column :response_id, :int
      t.column :survey_id, :int
    end
  end
end
