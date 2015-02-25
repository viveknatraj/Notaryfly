class AddCommentsToOrderFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :order_feedbacks, :comments, :text
  end

  def self.down
    remove_column :order_feedbacks, :comments
  end
end
