class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.references :template, foreign_key: true
      t.references :lesson, foreign_key: true
      t.integer :mark

      t.timestamps
    end
  end
end
