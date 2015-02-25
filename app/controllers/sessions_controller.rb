# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
#Im testing SVN Process
  # render new.rhtml
  def new
  end

  def create
    puts params.inspect
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")      
      handle_remember_cookie! new_cookie_flag
      if user.user_type == "client" and user.suspend!=1
        
        redirect_back_or_default(:controller => "/client/orders", :action => "index")
        session[:password] = params[:password]    
       user.user_signin = Time.now
       user.save
       flash[:notice] = "Logged in successfully"
       
      elsif  user.user_type == "notary" and user.suspend!=1
        @notary = Notary.find_by_user_id(self.current_user.id)
     multiple_notary = MultipleNotary.find_all_by_notary_id(@notary,:conditions => ["status ='not filled'"]).collect{|i|i.order_id}
      @orders = Order.find(:all, :conditions => ["id IN (?) AND status = 'need notary'", multiple_notary])
      if !@orders.blank?
        redirect_back_or_default(:controller => "/notary/orders", :action => "pending_orders")
      else
        redirect_back_or_default(:controller => "/notary/orders", :action => "index")
      end
        
        session[:password] = params[:password]
       user.user_signin = Time.now
       user.save
       flash[:notice] = "Logged in successfully"
       
      else user.suspend==1
       note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      flash[:notice] = "Your Account has been blocked by Administrator"
      redirect_back_or_default('/')
      end
     
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      flash[:notice] = "Please enter a valid email and password"
      redirect_back_or_default('/')
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
