class AddFeesAndProfessionalismToOrderFeedbacks < ActiveRecord::Migration
  def self.up
    add_column :order_feedbacks, :fees, :string
    add_column :order_feedbacks, :professionalism, :string
  end

  def self.down
    remove_column :order_feedbacks, :professionalism
    remove_column :order_feedbacks, :fees
  end
end
