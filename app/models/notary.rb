class Notary < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 40
  belongs_to :user
  has_attached_file :photo, :styles => {:small => "150x150>"}
  has_many :orders
  has_many :messages

  validates_presence_of :first_name
  validates_presence_of :last_name, :routing
  validates_numericality_of :other_fee
  
	validates_format_of :routing, :with => /^[0-9]{9}$/,  :message => "should be 9 digits (numeric only)"
  validates_confirmation_of :routing,:account,:message=>"doesn't match confirmation"
    validates_format_of :day_phone, :mobile_phone,
    :message => "must be a valid telephone number.",
    :with => /^[\(\)0-9\- \+\.]{10,20}$/

  #validates_presence_of :notary_commision_number
 # validates_presence_of :notary_commision_number_expiration_date
 #validates_presence_of :e_and_o_insurance_expiration_date, :if => Proc.new { |thing| thing.e_and_o_insurance == "Yes"  }

  acts_as_mappable
  
  def name
    first_name + " " + last_name
  end

  def self.user_name(user_id)
    @user_name = find_by_user_id(user_id)
    if @user_name
    return @user_name.first_name + " "+ @user_name.last_name
    end
  end

  def self.count_steps(user_id)
      @steps = User.find_by_id(user_id)
      return @steps.steps.to_i
  end

  def self.orders_count(notary_id)
    cnt = Order.count_by_sql "select count(*) from orders where notary_id = #{notary_id} and (status = 'closed' or status = 'filled');"
    return cnt
  end


  def upload_file(file)
    w_9 = file.original_filename
    self.w_9 = sanitize_filename(w_9)
    self.save
    save_uploaded_file(file,self.id)
  end

  def sanitize_filename(filename)
    filename=filename.downcase
    filename = File.basename(filename.gsub("\\", "/"))
    filename.gsub!(/[^a-zA-Z0-9\.\-\+_]/,"_")
    filename = "_#{filename}" if filename =~ /^\.+$/
    filename = "unnamed" if filename.size == 0
    return filename
  end

  def save_uploaded_file(uploaded_file,file_id)
    path_to_save = DOWNLOAD_FILES_ROOT + "#{file_id.to_s}/"
    FileUtils.mkdir(path_to_save) if  !File.directory?(path_to_save)
    file_name = uploaded_file.original_filename
    file_name = sanitize_filename(file_name)
    path = File.join(path_to_save, file_name)
    if !File.exists?(path)
      File.open(path, "wb") { |f| f.write(uploaded_file.read) }
    end
  end
end
