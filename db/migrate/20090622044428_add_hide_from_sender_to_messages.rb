class AddHideFromSenderToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :hide_from_sender, :boolean
  end

  def self.down
    remove_column :messages, :hide_from_sender
  end
end
