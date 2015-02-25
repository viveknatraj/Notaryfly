class CreateOrderExecutives < ActiveRecord::Migration
  def self.up
    create_table :order_executives do |t|
	    t.belongs_to :order
	    t.belongs_to :executive
    end
  end

  def self.down
    drop_table :order_executives
  end
end
