class AddSigningFeeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :signing_fee, :integer
  end

  def self.down
    remove_column :orders, :signing_fee
  end
end
