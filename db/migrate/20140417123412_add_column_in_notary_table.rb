class AddColumnInNotaryTable < ActiveRecord::Migration
  def self.up
    add_column :notaries, :fee, :integer
    add_column :notaries, :fee_type, :string
  end

  def self.down
    remove_column :notaries, :fee
    remove_column :notaries, :fee_type
  end
end
