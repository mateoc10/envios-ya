class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.float :lat
      t.float :long
      t.string :street
      t.float :number
      t.float :zipcode

      t.timestamps
    end
  end
end
