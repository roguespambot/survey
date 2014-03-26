class OpenEnded < ActiveRecord::Migration
  def change
    add_column :questions, :open_ended?, :boolean
  end
end
