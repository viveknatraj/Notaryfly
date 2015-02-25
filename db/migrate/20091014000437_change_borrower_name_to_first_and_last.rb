class ChangeBorrowerNameToFirstAndLast < ActiveRecord::Migration
  def self.up
    remove_column :orders, :borrower_1_name
    remove_column :orders, :borrower_2_name
    add_column :orders, :borrower_1_first_name, :string
    add_column :orders, :borrower_1_last_name, :string
    add_column :orders, :borrower_2_first_name, :string    
    add_column :orders, :borrower_2_last_name, :string
  end

  def self.down
    add_column :orders, :borrower_1_name, :string
    add_column :orders, :borrower_2_name, :string
    remove_column :orders, :borrower_1_first_name
    remove_column :orders, :borrower_1_last_name
    remove_column :orders, :borrower_2_first_name
    remove_column :orders, :borrower_2_last_name
  end
end
