class AddSuspendToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :suspend, :integer
  end

  def self.down
    remove_column :users, :suspend
  end
end
