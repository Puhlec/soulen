class AddStudentToLessons < ActiveRecord::Migration[6.0]
  def change
    add_reference :lessons, :student, foreign_key: true
  end
end
