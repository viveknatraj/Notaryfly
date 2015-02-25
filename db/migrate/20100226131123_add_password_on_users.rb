class AddPasswordOnUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_password, :string
  end

  def self.down
    remove_column :users, :user_password
  end
end
