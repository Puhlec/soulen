class AddFullnameToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :fullname, :string
  end
end
