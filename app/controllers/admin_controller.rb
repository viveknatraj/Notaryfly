class AdminController < ApplicationController

  def index
       session[:url] = 'http://www.notaryfly.com/admin'
      if session[:admin_user] != nil
      redirect_to :action => 'index'
      end
  end

   def signin
     if request.post?
       @check = Admin.find(:all,:conditions=>['username = ? and password = ?',params[:admin][:username],params[:admin][:password]])
       if(@check.size==1)
       session[:admin_user] = params[:admin]["username"]
       redirect_to :controller => "admin/orders" , :action => "open_order"
       else
         redirect_to :controller => "admin" ,:action => 'index',:login=>"no"
       end
     end
  end

  def logout
    session[:admin_user] = nil
    redirect_to :action => 'index'
  end


end
