class CreateExecutives < ActiveRecord::Migration
  def self.up
    create_table :executives do |t|
     t.string :name
     t.string :address
     t.string :city
     t.string :state
     t.string :account_name
     t.string :account_type
     t.string :account_holder_type
     t.integer :account_number
     t.integer :routing_number
    end
  end

  def self.down
    drop_table :executives
  end
end
