class AddTravelFeeToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :travel_fee, :string
  end

  def self.down
    remove_column :orders, :travel_fee
  end
end
