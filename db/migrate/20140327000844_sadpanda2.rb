class Sadpanda2 < ActiveRecord::Migration
  def change
        create_table :user_responses do |t|
      t.column :name, :string
    end

    add_column :question_responses, :user_response_id, :int
  end
end
