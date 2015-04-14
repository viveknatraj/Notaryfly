class AddOtherFeeToNotaries < ActiveRecord::Migration
  def self.up
    add_column :notaries, :other_fee, :integer
  end

  def self.down
    remove_column :notaries, :other_fee
  end
end
