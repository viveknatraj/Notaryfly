class AddAdminApproveToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_approve, :integer
  end

  def self.down
    remove_column :orders, :admin_approve
  end
end
