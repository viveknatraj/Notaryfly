class AddAdminCancelApproveToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_cancel_approve, :integer
  end

  def self.down
    remove_column :orders, :admin_cancel_approve
  end
end
