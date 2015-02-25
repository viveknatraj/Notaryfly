class AddNotificationToMultipleNotary < ActiveRecord::Migration
  def self.up
    add_column :multiple_notaries, :notification, :boolean,:default =>false
  end

  def self.down
    remove_column :multiple_notaries, :notification
  end
end
