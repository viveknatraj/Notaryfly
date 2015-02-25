class AddAdminCancelDescriptionToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :admin_cancel_description, :text
  end

  def self.down
    remove_column :orders, :admin_cancel_description
  end
end
