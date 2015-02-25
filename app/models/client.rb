class Client < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 40
  has_many :orders
  belongs_to :user
  has_many :messages
  has_many :client_executives
  has_many :executives, :through => :client_executives
  
  has_attached_file :attachment_1
  has_attached_file :attachment_2
  has_attached_file :attachment_3
  has_attached_file :attachment_4
  has_attached_file :attachment_5
  has_attached_file :attachment_6
#  validates_presence_of :company_name
#  validates_presence_of :client_name
#  validates_presence_of :title
#  validates_presence_of :address
#  validates_presence_of :city
#  validates_presence_of :client_state
#  validates_presence_of :zip_code
#  validates_presence_of :home_phone
  

  def self.user_name(user_id)
    @user_name = Client.find_by_user_id(user_id)
    @user_name=@user_name.client_name if @user_name!=nil
    return @user_name
  end

  def self.credit_details(user_id)
    @credits = Credit.find_by_user_id(user_id)
    return @credits
  end
  
end
