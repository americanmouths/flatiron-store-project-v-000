class RemoveInvetoryFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :invetory, :integer
  end
end
