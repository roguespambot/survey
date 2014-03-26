class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.column :name, :string
      t.timestamp
    end

    create_table :responses do |t|
      t.column :name, :string
      t.timestamp
    end

    create_table :surveys do |t|
      t.column :name, :string
      t.timestamp
    end

    create_table :questions_responses do |t|
      t.belongs_to :question
      t.belongs_to :response
      t.belongs_to :survey
    end

    create_table :takers do |t|
      t.column :name, :string
      t.timestamp
    end

    create_table :responses_selections do |t|
      t.belongs_to :taker
      t.column :question_response_id, :int
    end
  end
end
