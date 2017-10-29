class DeleteStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column(:shipments, :status, :string)
  end
end
