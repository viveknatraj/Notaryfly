class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :client_id
      t.integer :notary_id
      t.integer :broker_id
      t.string :loan_number
      t.date :signing_date
      t.time :signing_time
      t.string :loan_type
      t.integer :sets_of_docs
      t.integer :number_of_docs
      t.string :shipped_via
      t.string :tracking_number
      t.string :required_language
      t.boolean :attorney_required
      t.boolean :title_producer_required
      t.string :borrower_1_name
      t.string :borrower_1_work_phone
      t.string :borrower_1_extension
      t.string :borrower_1_home_phone
      t.string :borrower_1_mobile_phone
      t.string :borrower_2_name
      t.string :borrower_2_work_phone
      t.string :borrower_2_extension
      t.string :borrower_2_home_phone
      t.string :borrower_2_mobile_phone
      t.string :signing_location_address
      t.string :signing_location_city
      t.string :signing_location_state
      t.string :signing_location_zip_code
      t.text :special_instructions
      t.string :return_company_name   
      t.string :return_attention      
      t.string :return_address      
      t.string :return_city      
      t.string :return_state
      t.string :return_zip_code    
      t.string :return_account_number  
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
