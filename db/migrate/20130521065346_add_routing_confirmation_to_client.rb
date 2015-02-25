class AddRoutingConfirmationToClient < ActiveRecord::Migration
  def self.up
    add_column :clients, :routing_confirmation, :string
  end

  def self.down
    remove_column :clients, :routing_confirmation
  end
end
