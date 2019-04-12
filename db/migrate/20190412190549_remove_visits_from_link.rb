class RemoveVisitsFromLink < ActiveRecord::Migration[5.2]
  def up
    remove_column :links, :visits
  end

  def down 
    add_column :links, :visits
  end
end
