class AddFieldsToOrderFeedbacks < ActiveRecord::Migration
  def self.up
	add_column :order_feedbacks, :overall_rating, :decimal, :precision => 5, :scale => 2
	add_column :order_feedbacks, :notaryflyu_test, :boolean, :defalut => false
  end

  def self.down
	remove_column :order_feedbacks, :overall_rating
	remove_column :order_feedbacks, :notaryflyu_test
  end
end
