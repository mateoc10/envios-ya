class RemoveLocationDriver < ActiveRecord::Migration[5.1]
  def change
    remove_column :locations, :driver_id, :integer
  end
end
