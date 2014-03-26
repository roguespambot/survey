class AddMultipleChoice < ActiveRecord::Migration
  def change
    add_column :questions, :multiple_choice?, :boolean
  end
end
