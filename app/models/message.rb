class Message < ActiveRecord::Base
  has_one :notary
  has_one :client
  
  belongs_to :order

  
  has_attached_file :attachment_1
  has_attached_file :attachment_2
  has_attached_file :attachment_3
  has_attached_file :attachment_4
  has_attached_file :attachment_5
  has_attached_file :attachment_6
end
