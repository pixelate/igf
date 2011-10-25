class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :name
      t.integer :developer_id
      t.string :image_url
      t.integer :entry_id

      t.timestamps
    end
  end
end
