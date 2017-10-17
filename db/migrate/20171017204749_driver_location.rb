class DriverLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :location, :integer
    add_index :drivers, :location
  end
end
