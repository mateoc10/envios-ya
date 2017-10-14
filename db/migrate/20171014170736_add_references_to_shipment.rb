class AddReferencesToShipment < ActiveRecord::Migration[5.1]
  def change	
    add_column :shipments, :sender, :integer
    add_index :shipments, :sender
    
    add_column :shipments, :receiver, :integer
    add_index :shipments, :receiver
    
    add_column :shipments, :origin, :integer
    add_index :shipments, :origin
    
    add_column :shipments, :destination, :integer
    add_index :shipments, :destination
    
    add_column :shipments, :driver, :integer
    add_index :shipments, :driver
    
  end
end
