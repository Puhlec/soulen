class AddFunnyToStatuses < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :funny, :string
  end
end
