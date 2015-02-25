class CreateOrderFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :order_feedbacks do |t|
      t.integer :notary_id
      t.integer :client_id
      t.string :accuracy
      t.string :communication
      t.string :punctuality
      t.string :overall
      t.timestamps
    end
  end

  def self.down
    drop_table :order_feedbacks
  end
end
