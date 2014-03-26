class FixUserResponses < ActiveRecord::Migration
  def change
    add_column :question_responses, :user_response_id, :int
  end
end
