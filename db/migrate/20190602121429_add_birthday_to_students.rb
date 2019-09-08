class AddBirthdayToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :birthday, :date
  end
end
