class AddShipmentReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :shipments, :origin, foreign_key: { to_table: :locations }, index: true
    add_reference :shipments, :destination, foreign_key: { to_table: :locations }, index: true
  end
end
