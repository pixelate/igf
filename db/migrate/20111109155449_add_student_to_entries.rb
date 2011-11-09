class AddStudentToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :is_student, :boolean
  end
end
