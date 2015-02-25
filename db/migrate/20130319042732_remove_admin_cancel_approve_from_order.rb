class RemoveAdminCancelApproveFromOrder < ActiveRecord::Migration
  def self.up
    remove_column :orders, :admin_cancel_approve
  end

  def self.down
    add_column :orders, :admin_cancel_approve, :integer
  end
end
