class Executive < ActiveRecord::Base
   cattr_reader :per_page
   @@per_page = 10
   has_many :client_executives
   has_many :clients, :through => :client_executives
   has_many :order_executives
   has_many :orders, :through => :order_executives

	 validates_numericality_of :account_number, :routing_number
	 validates_format_of :routing_number, :with => /^[0-9]{9}$/,  :message => "should be 9 digits"
	 validates_presence_of :name, :address, :account_name, :account_type, :account_holder_type, :account_number, :routing_number
end
