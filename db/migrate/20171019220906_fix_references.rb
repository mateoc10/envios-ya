class FixReferences < ActiveRecord::Migration[5.1]
  def change
    add_reference :shipments, :driver, foreign_key: true
    
    add_reference :shipments, :sender, foreign_key: { to_table: :users }, index: true
    add_reference :shipments, :receiver, foreign_key: { to_table: :users }, index: true
    
    # add_reference :shipments, :location, foreign_key: true
    
    # add_reference :shipments, :location, foreign_key: true
  end
end
