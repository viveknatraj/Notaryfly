class CreateClientExecutives < ActiveRecord::Migration
  def self.up
    create_table :client_executives do |t|
	    t.belongs_to :client
	    t.belongs_to :executive
	    t.integer :share_percentage
	    t.integer :share_value
    end
  end

  def self.down
    drop_table :client_executives
  end
end
