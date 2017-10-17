class CreateShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :shipments do |t|
      t.integer :price
      t.date :date
      t.string :payment
      t.string :state

      t.timestamps
    end
  end
end
