class AddShippingSameAsContactInfoToClients < ActiveRecord::Migration
    def self.up
      add_column :clients, :shipping_same_as_contact_info, :boolean
    end

    def self.down
      remove_column :clients, :shipping_same_as_contact_info
    end
  end