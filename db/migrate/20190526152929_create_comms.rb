class CreateComms < ActiveRecord::Migration[6.0]
  def change
    create_table :comms do |t|
      t.string :author
      t.text :body
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
