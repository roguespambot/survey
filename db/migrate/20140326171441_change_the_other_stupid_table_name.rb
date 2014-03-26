class ChangeTheOtherStupidTableName < ActiveRecord::Migration
  def change
    drop_table :responses_selections
    create_table :response_selections do |t|
      t.column :taker_id, :int
      t.column :question_response_id, :int
    end
  end
end
