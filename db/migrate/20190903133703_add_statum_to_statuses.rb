class AddStatumToStatuses < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :statum, :string
  end
end
