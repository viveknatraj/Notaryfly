class AddLatLngToNotaries < ActiveRecord::Migration
  def self.up
    add_column :notaries, :lat, :float
    add_column :notaries, :lng, :float
  end

  def self.down
   remove_column :notaries, :lat
   remove_column :notaries, :lng
  end
end