class AddAccountConfirmationToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :account_confirmation, :string
  end

  def self.down
    remove_column :clients, :account_confirmation
  end
end
