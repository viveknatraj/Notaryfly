class AddOrderIdToFeedback < ActiveRecord::Migration
  def self.up
    add_column :order_feedbacks, :order_id, :string
  end

  def self.down
    remove_column :order_feedbacks, :order_id
  end
end
