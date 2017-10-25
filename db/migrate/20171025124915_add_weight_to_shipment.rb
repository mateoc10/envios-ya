class AddWeightToShipment < ActiveRecord::Migration[5.1]
  def change
     add_column :shipments, :weight, :float
     add_column :shipments, :status, :string
  end
end
