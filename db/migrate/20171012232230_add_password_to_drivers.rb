class AddPasswordToDrivers < ActiveRecord::Migration[5.1]
  def change
    add_column  :drivers, :password, :string
  end
end
