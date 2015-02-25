class AddResponseFromNotaryToOrderFeedback < ActiveRecord::Migration
  def self.up
	add_column :order_feedbacks, :response_from_notary, :string
  end

  def self.down
	remove_column :order_feedbacks, :response_from_notary
  end
end
