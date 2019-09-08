class AddVideoToLessons < ActiveRecord::Migration[6.0]
  def change
    add_column :lessons, :video, :string
  end
end
