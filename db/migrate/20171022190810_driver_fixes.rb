class DriverFixes < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :location, :integer
    add_index :drivers, :location
    add_reference :drivers, :location, foreign_key: { to_table: :locations }, index: true
  end
end
