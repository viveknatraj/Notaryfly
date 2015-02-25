require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken

  validates_presence_of     :login
  validates_length_of       :login,    :within => 3..40
  validates_uniqueness_of   :login,    :case_sensitive => false
  validates_format_of       :login,    :with => RE_LOGIN_OK, :message => MSG_LOGIN_BAD

  validates_format_of       :name,     :with => RE_NAME_OK,  :message => MSG_NAME_BAD, :allow_nil => true
  validates_length_of       :name,     :maximum => 100

  validates_presence_of     :email
  validates_length_of       :email,    :within => 6..100 #r@a.wk
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => RE_EMAIL_OK, :message => MSG_EMAIL_BAD
  validates_confirmation_of :email,
                              :message => "doesn't match confirmation"

  # HACK HACK HACK -- how to do attr_accessible from here?
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :name, :password, :password_confirmation, :user_type,:email_confirmation



  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  #
  # uff.  this is really an authorization, not authentication routine.  
  # We really need a Dispatch Chain here or something.
  # This will also let us return a human error message.
  #
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt    
    u && u.authenticated?(password) ? u : nil
  end

  def upload_file(file)
    file_name = file.original_filename
    self.file_name = sanitize_filename(file_name)
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
  
  protected

  


end
