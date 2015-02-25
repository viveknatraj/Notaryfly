class AddOrderNotaryFieldsToOrders < ActiveRecord::Migration
    def self.up
      add_column :orders, :order_notary_name, :string
      add_column :orders, :order_notary_company_name, :string
      add_column :orders, :order_notary_contact_address, :string
      add_column :orders, :order_notary_contact_city, :string
      add_column :orders, :order_notary_contact_state, :string
      add_column :orders, :order_notary_contact_zip_code, :string
      add_column :orders, :order_notary_home_phone, :string
      add_column :orders, :order_notary_mobile_phone, :string
      add_column :orders, :order_notary_work_phone, :string
      add_column :orders, :order_notary_work_extension, :string
      add_column :orders, :order_notary_fax_number, :string
      add_column :orders, :order_notary_email_address, :string
      add_column :orders, :order_notary_payment_address, :string
      add_column :orders, :order_notary_payment_city, :string
      add_column :orders, :order_notary_payment_state, :string
      add_column :orders, :order_notary_payment_zip_code, :string
      add_column :orders, :order_notary_fee, :string
    end

    def self.down
      remove_column :orders, :order_notary_name
      remove_column :orders, :order_notary_company_name
      remove_column :orders, :order_notary_contact_address
      remove_column :orders, :order_notary_contact_city
      remove_column :orders, :order_notary_contact_state
      remove_column :orders, :order_notary_contact_zip_code
      remove_column :orders, :order_notary_home_phone
      remove_column :orders, :order_notary_mobile_phone
      remove_column :orders, :order_notary_work_phone
      remove_column :orders, :order_notary_work_extension
      remove_column :orders, :order_notary_fax_number
      remove_column :orders, :order_notary_email_address
      remove_column :orders, :order_notary_fax_number
      remove_column :orders, :order_notary_payment_address
      remove_column :orders, :order_notary_payment_city
      remove_column :orders, :order_notary_payment_state
      remove_column :orders, :order_notary_payment_zip_code
      remove_column :orders, :order_notary_fee
    end
  end
