class CreateMultipleNotaries < ActiveRecord::Migration
  def self.up
    create_table :multiple_notaries do |t|
	t.integer :order_id
	t.integer :notary_id
      	t.timestamps
      t.timestamps
    end
  end

  def self.down
    drop_table :multiple_notaries
  end
end
