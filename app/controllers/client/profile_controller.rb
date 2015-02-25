class Client::ProfileController < ApplicationController
  include SslRequirement
  ssl_required  :buy_credits, :add_credits
  
  before_filter :credits
  before_filter :require_login_client
  def index
    @client = Client.find_by_user_id(self.current_user.id)
  end
  
  def shipping
    @client = Client.find_by_user_id(self.current_user.id)
  end
  
  def instructions
    @client = Client.find_by_user_id(self.current_user.id)
  end
  
  def delete_attachment
    @client = Client.find_by_user_id(self.current_user.id)
    attachment = "attachment_" + params[:id]
    @client.update_attribute(attachment, nil)
    redirect_to :action => "instructions"
  end
  
  def update
    @client = Client.find_by_user_id(self.current_user.id)
    @user = User.find(@client.user_id)
    session[:password] = params[:user][:password]

#    if params[:user][:password] == '12345678'
#       params[:user][:password] = nil
#    end
    
#    if params[:user][:password_confirmation] == '12345678'
#       params[:user][:password] = nil
#    end
   @userPwd = User.find(self.current_user.id)
       @userPwd.user_password = params[:user][:password]
       @userPwd.save
    if params[:client][:shipping_same_as_contact_info] == "1"
      params[:client][:shipping_address] = @client.address
      params[:client][:shipping_city] = @client.city
    end

    @client.update_attributes(params[:client])
    @user.update_attributes(params[:user])

    if @client.errors.empty?
      redirect_to :back
      flash[:notice] = "Your information has been updated"
    else
      render :action => "index"
    end
  end
  
  def buy_credits
    @promocode = Promocode.find_by_id(1)
    flash[:error] = false
    time = Time.new
    @year = time.year
    @month =  time.month
  end
  
  def add_credits
    @promocode = Promocode.find_by_id(1)
    # Send requests to the gateway's test servers
    
#   ActiveMerchant::Billing::Base.mode = :production
   ActiveMerchant::Billing::Base.gateway_mode = :test 
   @credit_num = params[:client][:credit_card_number]
   @card_veification_number = params[:client][:card_veification_number]
   @first_name = params[:client][:card_holder_name]
   @billing_address = params[:client][:billing_address]
   @city = params[:client][:city]
   @state = params[:client][:state]
   @zip_code = params[:client][:zip_code]
   @selectd_credits = params[:client][:credit]
   if @selectd_credits == "1"
     @one_credits = true
   elsif @selectd_credits == "5"
     @five_credits = true
   elsif @selectd_credits == "10"
     @ten_credits = true
   else
     @one_credits = false
     @five_credits = false
     @ten_credits = false
   end
   @month   = params[:date]["month"]
   @year   = params[:date]["year"]
    # Create a new credit card object
    credit_card = ActiveMerchant::Billing::CreditCard.new(
     :number => '4242424242424242', #Authorize.net test card, error-producing
    # :number => '4007000000027', #Authorize.net test card, non-error-producing
#      :number     => params[:client][:credit_card_number],
      :month      => params[:date]["month"],
      :year       => params[:date]["year"],
      :first_name => params[:client][:card_holder_name],
      :last_name  => params[:client][:card_holder_name],
      :verification_value  => params[:client][:card_veification_number]
    )

    if credit_card.valid?

      # Create a gateway object to the Authorize Net service
      gateway = ActiveMerchant::Billing::AuthorizeNetGateway.new(
        :login    => '553aYdD2w',	
        :password => '985ak6FV92bbEtVk', :test => 'FALSE'
      )

      # Authorize for $49, $195, or $295 dollars
      @purchase_credits = params[:client][:credit]
      purchase_amount = @purchase_credits.to_i

      credits = purchase_amount
      
      if purchase_amount == 1
        amount = 4900
      elsif purchase_amount == 5
        amount = 19500
      elsif purchase_amount == 10
        amount = 29500
      end  
      response = gateway.authorize(amount, credit_card)

      if response.success?
        # Capture the money
        gateway.capture(amount, response.authorization)
        
        @credit = Credit.find_by_user_id(self.current_user.id)
        new_amount = @credit.credits + purchase_amount
        if @credit.total_credits!=nil
          total_credits = @credit.total_credits + purchase_amount
        else
          total_credits = purchase_amount
        end
        promo_code = params[:client][:promo_code]

        promo = "No"
        
        if promo_code==@promocode.promocode
          new_amount = new_amount+@promocode.credits.to_i
          credits = credits+@promocode.credits.to_i
          total_credits = total_credits+@promocode.credits.to_i
          promo = "Yes"
        end
        
        @credit.update_attributes(:credits=>new_amount, :total_credits=>total_credits)

        @invoice = Invoice.new

        @invoice.client_id = self.current_user.id
        @invoice.promo_code = promo
        @invoice.save
         invoice_no = Invoice.maximum('id')
         @clients = Client.find_by_user_id(self.current_user.id)
         @client_mail = User.find_by_id(self.current_user.id)
         
      # Notifier.deliver_notary_credits_purchase(@clients.client_name,invoice_no,purchase_amount,promo,credits,@client_mail.email)
       
        redirect_to :action => "buy_credits"
        flash[:notice] = "Your have purchased " + @purchase_credits + " credits. Your credit card has been charged and we have added the credits to your account."

      else
        render :action => "buy_credits"
        raise StandardError, response.message
        # raise StandardError, response.message 
      end
      
    else
      flash[:error] = "We're sorry, there was an error with your credit card information."
      render :action => "buy_credits"
   
    end

  end
  
end
