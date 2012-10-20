class AddEventIdToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :event_id, :int
  end
end
