class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.integer :visits, default: 0
      t.string :slug, null: false
      t.string :base_url, null: false
      t.string :body, null: false
      t.string :full_link, null: false

      t.timestamps
    end
  end
end
