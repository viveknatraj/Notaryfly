class AddNotaryFeeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :notary_fee, :string
  end

  def self.down
    remove_column :orders, :notary_fee
  end
end
