class AddColumnTravelDistanceInNotaryTable < ActiveRecord::Migration
  def self.up
    add_column :notaries, :travel_distance, :integer
  end

  def self.down
    remove_column :notaries, :travel_distance
  end
end
