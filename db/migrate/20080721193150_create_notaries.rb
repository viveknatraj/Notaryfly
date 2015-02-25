class CreateNotaries < ActiveRecord::Migration
  def self.up
    create_table :notaries do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :company_name
      t.string :day_phone
      t.string :evening_phone
      t.string :mobile_phone
      t.string :work_phone
      t.string :fax_number
      t.string :fee_single_loan_overnight
      t.string :fee_single_loan_email
      t.string :fee_1st_and_2nd_overnight
      t.string :fee_1st_and_2nd_email
      t.string :notary_commision_number
      t.string :notary_commision_number_expiration_date
      t.string :e_and_o_insurance
      t.string :e_and_o_insurance_amount
      t.string :e_and_o_insurance_expiration_date
      t.string :weekday_deliver_address
      t.string :weekday_deliver_city
      t.string :weekday_deliver_state
      t.string :weekday_deliver_zip_code
      t.string :weekend_deliver_address
      t.string :weekend_deliver_city
      t.string :weekend_deliver_state
      t.string :weekend_deliver_zip_code
      t.string :billing_payable_to
      t.string :billing_deliver_address
      t.string :billing_deliver_city
      t.string :billing_deliver_state
      t.string :billing_deliver_zip_code
      t.string :email_document_capability
      t.string :laser_printer
      t.string :printer_paper_type
      t.string :enotarization_capability
      t.string :own_a_copier
      t.string :notary_history_length
      t.string :notarize_loan_documents
      t.string :notarized_documents_count
      t.string :title_insurance_provider
      t.string :bilingual
      t.string :bilingual_language
      t.string :refinance
      t.string :purchases
      t.string :lines_of_credit
      t.string :power_of_attorney
      t.string :sellers_packaging
      t.string :reverse_mortgage
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :notaries
  end
end
