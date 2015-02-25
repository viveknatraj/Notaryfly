class RenameNumberOfDocsToDeliveryType < ActiveRecord::Migration
  def self.up
    remove_column :orders, :number_of_docs
    add_column :orders, :delivery_options, :string
    
  end

  def self.down
    add_column :orders, :number_of_docs, :string
    remove_column :orders, :delivery_options    
  end
end
