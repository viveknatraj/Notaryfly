class AddColumnW9InfoInNotaryTable < ActiveRecord::Migration
  def self.up
    add_column :notaries, :w9_info, :string
  end

  def self.down
    remove_column :notaries, :w9_info
  end
end
