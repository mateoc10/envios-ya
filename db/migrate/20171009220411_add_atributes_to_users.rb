class AddAtributesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lastName, :string
    add_column :users, :document, :string
    add_column :users, :photo, :string
  end
end
