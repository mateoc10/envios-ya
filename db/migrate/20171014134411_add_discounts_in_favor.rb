class AddDiscountsInFavor < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :discounts, :integer
    add_column :users, :new_user, :boolean
  end
end
