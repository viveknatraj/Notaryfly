class AddOtherFeeReasonToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :other_fee_reason, :text
  end

  def self.down
    remove_column :orders, :other_fee_reason
  end
end
