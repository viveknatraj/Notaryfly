class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :user_id
      t.string :company_name
      t.string :client_name
      t.string :title
      t.string :address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :home_phone
      t.string :home_extension
      t.string :direct_phone
      t.string :mobile_phone
      t.string :fax_number
      t.string :email_address
      t.text :special_instructions
      t.string :shipping_company_name
      t.string :shipping_attention
      t.string :shipping_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip_code
      t.string :shipping_courier
      t.string :shipping_account_number
      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
