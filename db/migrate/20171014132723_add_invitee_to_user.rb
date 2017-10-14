class AddInviteeToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :invitee, :integer
    add_index :users, :invitee
  end
end
