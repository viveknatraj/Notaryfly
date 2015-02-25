class AddSigninToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_signin, :datetime
  end

  def self.down
    remove_column :users, :user_signin
  end
end
