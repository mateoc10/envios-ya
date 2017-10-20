class DriverLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :driver, foreign_key: true
  end
end
