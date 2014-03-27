class DropUserResponse < ActiveRecord::Migration
  def change
    drop_table :user_responses

    remove_column :question_responses, :user_response_id, :int
  end
end
