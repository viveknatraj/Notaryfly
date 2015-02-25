class CreateClientBrokers < ActiveRecord::Migration
  def self.up
    create_table :client_brokers do |t|
      t.integer :client_id
      t.string :company_name
      t.string :broker_name
      t.string :title
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :home_phone
      t.string :home_extension
      t.string :direct_phone
      t.string :mobile_phone
      t.timestamps
    end
  end

  def self.down
    drop_table :client_brokers
  end
end
