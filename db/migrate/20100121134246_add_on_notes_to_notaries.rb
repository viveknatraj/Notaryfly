class AddOnNotesToNotaries < ActiveRecord::Migration
  def self.up
    add_column :notaries, :notes, :text
  end

  def self.down
    remove_column :notaries, :notes
  end
end
