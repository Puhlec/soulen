class AddTempusToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :tempus, :datetime
  end
end
