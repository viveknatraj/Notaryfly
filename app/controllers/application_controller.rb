# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  include SslRequirement
  ssl_required  :buy_credits
  
  before_filter :session_expiry
  #helper :all # include all helpers, all the time
  before_filter :messages, :feedback_needed_count
  #before_filter :require_login_client
  #before_filter :require_login_notary


    
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '8f94a9a2c137902a2c454d3f3852bd00'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
    include AuthenticatedSystem
    

  def require_login_client
   if logged_in?
     unless current_user.user_type=="client"
        redirect_to '/'
     end
   end
    
    if current_user.blank?
        redirect_to '/'
	flash[:notice] = "Your Session has expired"
    end
  end

  def require_login_notary
   if logged_in?
   unless current_user.user_type=="notary"
   redirect_to '/'
   end
   end
    
    if current_user.blank?
        redirect_to '/'
	flash[:notice] = "Your Session has expired"
    end

  end


    def credits
      if current_user
      @credits = Credit.find_by_user_id(self.current_user.id)
      end
    end
    
    def messages
      if logged_in?
        @unread_messages = Message.find(:all, :conditions => ["is_unread IS true AND recipient_id = ?", self.current_user.id])
      end
    end
    
    def feedback_needed_count
      if logged_in?
        @feedback_needed_count = Order.find(:all, :conditions => ["feedback = 'needed' AND status = 'closed' AND client_id = ? ", self.current_user.id])        
      end
    end

    MAX_SESSION_PERIOD = 5400
    
    def session_expiry
          login_url = "http://www.notaryfly.com/logout"

          if session[:expiry_time] and session[:expiry_time] < Time.now
          reset_session
          redirect_to '/'
          end

        session[:expiry_time] = MAX_SESSION_PERIOD.seconds.from_now
        return true
  end

end
