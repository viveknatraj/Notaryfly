class CreateOrderAttachments < ActiveRecord::Migration
  def self.up
    create_table :order_attachments do |t|
      t.references :order
      t.timestamps
    end
  end

  def self.down
    drop_table :order_attachments
  end
end
