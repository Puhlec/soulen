class AddDatexamsToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :datexam, :date
  end
end
