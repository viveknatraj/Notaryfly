class AddSampleToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :sample, :integer
  end

  def self.down
    remove_column :orders, :sample
  end
end
