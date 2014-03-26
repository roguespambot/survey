class CreateUserResponses < ActiveRecord::Migration
  def change
    create_table :user_responses do |t|
      t.column :name, :string
    end
  end
end
