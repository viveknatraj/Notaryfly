class UsersController < ApplicationController
  include SslRequirement
  ssl_required  :buy_credits
  
  def new_notary
    @user = User.new
  end
 
  def create_notary
    logout_keeping_session!
    params[:user][:login] = params[:user][:email]
    @user = User.new(params[:user])
    @user.user_type = "notary"
    @user.steps = "1"
    @notary = Notary.new(params[:notary])
    if request.post?
      @notary.upload_file(params[:notary][:w_9]) if !params[:notary][:w_9].nil?
    end
    @e_and_o_insurance = params[:notary]["e_and_o_insurance"]
    success = @user && @user.save && @notary && @notary.save
    if success && @user.errors.empty? && @notary.errors.empty?

      self.current_user = @user # !! now logged in
      @notary.update_attribute(:user_id, self.current_user.id)
      @userPwd = User.find(self.current_user.id)
      @userPwd.user_password = params[:user][:password]
      @userPwd.save
      session[:password]   = params[:user][:password]
      Notifier.deliver_notary_signup(@user,params[:user][:password]) #notary signup email
      redirect_back_or_default(:controller => "notary/profile", :action => "address")
       
      flash[:notice] = "Please continue your sign up by completing your address information"
    else
      if @user
        @user.destroy
      end
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :controller => "users", :action => 'new_notary'
    end
  end
  
  def new_client
    @user = User.new
    @client = Client.new
  end
 
  def create_client
   
    logout_keeping_session!
    params[:user][:login] = params[:user][:email]
    @user = User.new(params[:user])
    @user.user_type = "client"
    success = @user && @user.save
    if success && @user.errors.empty?
      self.current_user = @user # !! now logged in
      @client = Client.new(params[:client])
      @client.user_id = self.current_user.id
      @client.save
       
      @credit = Credit.new(:user_id => self.current_user.id, :credits => 0, :total_credits => 0)
      @credit.save
      @userPwd = User.find(self.current_user.id)
      @userPwd.user_password = params[:user][:password]
      @userPwd.save
      session[:password]   = params[:user][:password]
      redirect_back_or_default(:controller => "/client/profile", :action => "instructions")
      Notifier.deliver_client_signup(@user,params[:user][:password])        #client signup email
      flash[:notice] = "Thanks for signing up! Please continue to build your profile by filling out the information below and your shipping information."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again."
      render :controller => "users", :action => 'new_client'
    end
  end

  def check_status

    order_id = Order.find_by_id(params[:order_number])

    if order_id 
      if order_id.notary_id

        borrower = order_id.borrower_1_last_name

        if  borrower.to_s.casecmp(params[:last_name])==0
          render :update do |page|
            page.replace_html "error" , ""
            if (order_id.status_timeline == "Notary Assigned")
              page.replace_html "notary123" ,"<b>Order Timeline: #{order_id.status_timeline}</b><br/><br/>#{image_tag("step_2.png")}"
            elsif (order_id.status_timeline == "Time/Date Signing Set" || order_id.status_timeline == "Documents Recceived by Notary")
              page.replace_html "notary123" ,"<b>Order Timeline: #{order_id.status_timeline}</b><br/><br/>#{image_tag("step_3.png")}"
            elsif (order_id.status_timeline == "Signing Completed")
              page.replace_html "notary123" ,"<b>Order Timeline: #{order_id.status_timeline}</b><br/><br/>#{image_tag("step_4.png")}"
            elsif (['Notary Paid in Full', 'Paid'].include? order_id.status_timeline)
              page.replace_html "notary123" ,"<b>Order Timeline: #{order_id.status_timeline}</b><br/><br/>#{image_tag("step_5.png")}"
            elsif (order_id.status_timeline.nil?)
              page.replace_html "notary123" ,"<b>Order Timeline: #{order_id.status_timeline}</b><br/><br/>#{image_tag("step_1.png")}"
            end
          end
        else
          render :update do |page|
            page.replace_html "notary123" ,""
            page.replace_html "error" ,"Last Name is wrong. Please enter the information correctly"
          end

        end
      else
        render :update do |page|
          page.replace_html "notary123" ,""
          page.replace_html "error" , "Notary has not been assigned for this Order Number"
        end
      end
    else
      render :update do |page|
        page.replace_html "notary123" ,""
        page.replace_html "error" ,"Order Number or Last Name is wrong. Please enter the information correctly"
      end
    end
  end

end
