class AddFeedbackToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :feedback, :string
  end

  def self.down
    remove_column :orders, :feedback
  end
end
