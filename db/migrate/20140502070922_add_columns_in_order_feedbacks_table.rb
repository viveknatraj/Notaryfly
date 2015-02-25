class AddColumnsInOrderFeedbacksTable < ActiveRecord::Migration
  def self.up
    add_column :order_feedbacks, :client_professionalism, :string
    add_column :order_feedbacks, :status_update, :string
    add_column :order_feedbacks, :doc_issue, :string
    add_column :order_feedbacks, :satisfaction, :string
  end

  def self.down
    remove_column :order_feedbacks, :client_professionalism, :string
    remove_column :order_feedbacks, :status_update, :string
    remove_column :order_feedbacks, :doc_issue, :string
    remove_column :order_feedbacks, :satisfaction, :string
  end
end
