class ClientExecutive < ActiveRecord::Base
	belongs_to :client
	belongs_to :executive
end
