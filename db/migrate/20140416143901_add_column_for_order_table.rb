class AddColumnForOrderTable < ActiveRecord::Migration
  def self.up
    add_column :orders, :cc_email, :string
  end

  def self.down
    remove_column :orders, :cc_email
  end
end
