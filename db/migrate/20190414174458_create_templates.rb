class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.references :instructor, foreign_key: true
      t.string :pictogram

      t.timestamps
    end
  end
end
