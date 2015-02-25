require 'paperclip'

class OrderAttachment < ActiveRecord::Base
  belongs_to :order
  has_attached_file :data
end
