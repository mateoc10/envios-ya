class CreateDrivers < ActiveRecord::Migration[5.1]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :last_name
      t.string :email
      t.string :document
      t.string :photo
      t.string :img_license
      t.string :documentation
      t.boolean :available
      t.boolean :active

      t.timestamps
    end
  end
end
