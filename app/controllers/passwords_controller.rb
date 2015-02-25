class PasswordsController < ApplicationController
  include SslRequirement
  ssl_required  :buy_credits
  
  def new
    @password = Password.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @password }
    end
  end

  def create
    @password = Password.new(params[:password])
    @password.user = User.find_by_email(@password.email)
    
    respond_to do |format|
      @password_err = "";
      if @password.save
        PasswordMailer.deliver_forgot_password(@password)
        flash[:notice] = "A link to change your password has been sent to #{@password.email}."
        format.html { redirect_to '/' }
        format.xml  { render :xml => @password, :status => :created, :location => @password }
      else
        # use a friendlier message than standard error on missing email address
        if @password.errors.on(:user)
          @password.errors.clear
          @password_err = "Entered email is doesn't exist."
          flash[:error] = "We can't find a eterter with that email. Please check the email address and try again..."
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @password.errors, :status => :unprocessable_entity }
      end
    end
  end

  def reset
    begin
      @user = Password.find(:first, :conditions => ['reset_code = ? and expiration_date > ?', params[:reset_code], Time.now]).user
    rescue
      flash[:notice] = 'The change password URL you visited is either invalid or expired.'
      redirect_to(new_password_path)
    end    
  end

  def update_after_forgetting
    @password = Password.find_by_reset_code(params[:reset_code])
    @user = @password.user unless @password.nil?
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
       @password.destroy
        @user_Pwd = User.find_by_id(@password.user_id)
        @user_Pwd.user_password = params[:user][:password]
        @user_Pwd.save
        PasswordMailer.deliver_reset_password(@user)
        flash[:notice] = "Password was successfully updated. Please log in."
        format.html { redirect_to :controller => "home", :action => "index"}
      else
        flash[:notice] = 'There was a problem resetting your password. Please try again.'
        format.html { render :action => :reset, :reset_code => params[:reset_code] }
      end
    end
  end
  
end
