class RemoveDriversDocumentation < ActiveRecord::Migration[5.1]
  def change
    remove_column  :drivers, :documentation
  end
end
