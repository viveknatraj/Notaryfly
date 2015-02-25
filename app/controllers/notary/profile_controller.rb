class Notary::ProfileController < ApplicationController
 before_filter :require_login_notary
  def index
    @notary = Notary.find_by_user_id(self.current_user.id)
  end
  
  def address
    @notary = Notary.find_by_user_id(self.current_user.id)
  end
  
  def experience
    @notary = Notary.find_by_user_id(self.current_user.id)
  end

  def my_fees
    @notary = Notary.find_by_user_id(self.current_user.id)
    fee = OrderFeedback.find_by_notary_id(@notary)
    @overall_rating = []
    order = OrderFeedback.find_all_by_notary_id(@notary)
    order.each do |order1|
      @total_feedbacks = order1.accuracy.to_i + order1.communication.to_i + order1.punctuality.to_i + order1.professionalism.to_i + order1.fees.to_i
      @overall_rating << @total_feedbacks.to_f / 5
    end
    @rating_3_4 = @overall_rating.select{ |i| i >= 3.00 and i<= 3.99}.size
    @rating_4_5 = @overall_rating.select{ |i| i >= 4.00 and i<= 5.00}.size
    @current_fee = 50
    @notary_test = 'Not Completed'
    if fee && fee.notaryflyu_test
      @current_fee = 75
      @notary_test = 'Completed'
    end
    if fee && fee.notaryflyu_test
      if @rating_3_4 >= 100 and @rating_4_5 >= 50
        @current_fee = 85
      elsif @rating_3_4 >= 100 or @rating_4_5 >= 50
        @current_fee = 80
      end
      if @rating_3_4 >= 200 and @rating_4_5 >= 100
        @current_fee = 95
      elsif @rating_3_4 >= 200 or @rating_4_5 >= 100
        @current_fee = 90
      end
      if @rating_3_4 >= 300 and @rating_4_5 >= 150
        @current_fee = 105
      elsif @rating_3_4 >= 300 or @rating_4_5 >= 150
        @current_fee = 100
      end
      if @rating_3_4 >= 400 and @rating_4_5 >= 200
        @current_fee = 120
      elsif @rating_3_4 >= 400 or @rating_4_5 >= 200
        @current_fee = 115
      end
      if @rating_3_4 >= 500 or @rating_4_5 >= 250
        @current_fee = 125
      end
    else
      if @rating_3_4 >= 100 and @rating_4_5 >= 50
        @current_fee = 60
      elsif @rating_3_4 >= 100 or @rating_4_5 >= 50
        @current_fee = 55
      end
      if @rating_3_4 >= 200 and @rating_4_5 >= 100
        @current_fee = 70
      elsif @rating_3_4 >= 200 or @rating_4_5 >= 100
        @current_fee = 65
      end
      if @rating_3_4 >= 300 and @rating_4_5 >= 150
        @current_fee = 80
      elsif @rating_3_4 >= 300 or @rating_4_5 >= 150
        @current_fee = 75
      end
      if @rating_3_4 >= 400 and @rating_4_5 >= 200
        @current_fee = 90
      elsif @rating_3_4 >= 400 or @rating_4_5 >= 200
        @current_fee = 85
      end
      if @rating_3_4 >= 500 and @rating_4_5 >= 250
        @current_fee = 100
      elsif @rating_3_4 >= 500 or @rating_4_5 >= 250
        @current_fee = 95
      end
      if @rating_3_4 >= 600 and @rating_4_5 >= 300
        @current_fee = 110
      elsif @rating_3_4 >= 600 or @rating_4_5 >= 300
        @current_fee = 105
      end
      if @rating_3_4 >= 700 and @rating_4_5 >= 350
        @current_fee = 120
      elsif @rating_3_4 >= 700 or @rating_4_5 >= 350
        @current_fee = 115
      end
      if @rating_3_4 >= 800 or @rating_4_5 >= 400
        @current_fee = 125
      end
    end

  end
  
  def update
    @notary = Notary.find_by_user_id(self.current_user.id)
    @user_pwd_update = User.find(@notary.user_id)   

    if params[:notary][:e_and_o_insurance] == 'No'
      params[:notary][:e_and_o_insurance_amount] = 0
    end

    if request.post?
      @notary.upload_file(params[:notary][:w_9]) if !params[:notary][:w_9].nil?
    end

    @user_pwd_update.update_attributes(params[:user].merge!(:user_password => params[:user][:password]))
    #@userPwd = User.find(self.current_user.id)
    #@userPwd.user_password = params[:user][:password]
    #@userPwd.save

    session[:password] = params[:user][:password]
    if @notary.weekday_deliver_zip_code
          #coordinates = GeoKit::Geocoders::GoogleGeocoder.geocode(@notary.weekday_deliver_zip_code)
      coordinates = Geokit::Geocoders::GoogleGeocoder3.geocode(@notary.weekday_deliver_zip_code)
   
      @notary.update_attributes(:lat => coordinates.lat, :lng => coordinates.lng)
    end

    if self.current_user.steps.to_i < 3
      @user = self.current_user
      if params[:steps][:page] == "experience"
        @user.update_attribute(:steps, "3")
        redirect_to :controller => "notary/orders", :action => "index"
        flash[:notice] = "Your account has been completed. Thanks for signing up!"
      elsif params[:steps][:page] == "address"
        @user.update_attribute(:steps, "2")
        redirect_to :controller => "notary/profile", :action => "experience"
        flash[:notice] = "Please complete your skills and experience to finish setting up your account"
      elsif params[:steps][:page] == "index"
        @user.update_attribute(:steps, "1")
        redirect_to :controller => "notary/profile", :action => "address"
        flash[:notice] = "Please complete your address information to finish setting up your account"    
      end
    else
      if @notary.update_attributes(params[:notary])
        redirect_to :back
        flash[:notice] = "Your information has been updated"
      else
        if params[:steps] && params[:steps][:page] == "address"
          render :action => :address
        elsif params[:steps] && params[:steps][:page] == "experience"
          render :action => :experience
        else
          render :action => :index
        end
      end
    end
  rescue
    redirect_to :action => :index
  end

  def notaryflyu
    redirect_to :action => :index
  end

  def fee_update
    @notary = Notary.find_by_user_id(self.current_user.id)
    if @notary.update_attributes(params[:notary])
      flash[:notice] = "Notary fee updated"
      redirect_to :action => :my_fees
    else
      my_fees
      render :action => :my_fees
    end
  rescue
    flash[:error] = "Cannot update the notary fee"
    redirect_to :action => :my_fees
  end
  
end
