class OrderExecutive < ActiveRecord::Base
	belongs_to :order
	belongs_to :executive
end
