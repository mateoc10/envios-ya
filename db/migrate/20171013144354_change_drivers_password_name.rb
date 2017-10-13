class ChangeDriversPasswordName < ActiveRecord::Migration[5.1]
  def change
    add_column  :drivers, :password_digest, :string
    remove_column :drivers, :password
  end
end
