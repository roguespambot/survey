class AddOtherField < ActiveRecord::Migration
  def change
    add_column :questions, :other?, :boolean
  end
end
