class CreateTableInvoice < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.integer :client_id
      t.string  :promo_code
    end
  end

  def self.down
    drop_table :invoices
  end
end
