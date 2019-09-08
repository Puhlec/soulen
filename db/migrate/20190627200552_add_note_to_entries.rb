class AddNoteToEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :note, :string
  end
end
