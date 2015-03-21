class Notary::OrdersController < ApplicationController
  before_filter :require_login_notary

  def index
    @notary = Notary.find_by_user_id(self.current_user.id)
    sort_by = {
        "Signer Name" => "borrower_1_last_name ASC",
        "Appointment Scheduled" => "signing_date ASC",
        "NF #" => "loan_number ASC",
        "Order Opened" => "created_at DESC",
    }
    @filter = sort_by[params[:filter]] rescue nil
    @filter ||= "created_at DESC"
    #@multiple_notary = MultipleNotary.find_all_by_notary_id(@notary,:conditions => ["status ='not filled'"]).collect{|i|i.order_id}
    #@orders = Order.find(:all, :conditions => ["(id IN (?) AND status = 'need notary') OR (notary_id = ? AND status = 'filled') OR (notary_id = ? AND status = 'Refuse To Sign')", @multiple_notary, @notary.id, @notary.id ], :order => @filter)
    notary = Notary.find_by_user_id(current_user.id)
    @orders = Order.find(:all, :conditions => ["status!=? AND notary_id=?", 'closed', notary.id], :order => @filter)

    @pending_orders   = []
    @assigned_orders  = []
    @confirmed_orders = []
    @rts_orders       = []
    @signed_orders    = []
    @paid_orders      = []

    @orders.each do |order|
      @pending_orders   << order if order.status == "need notary" && !order.notary_id.present?
      @assigned_orders  << order if order.status == "filled" && order.status_timeline == "Notary Assigned" && order.notary_id.present?
      @confirmed_orders << order if order.status != "Refuse To Sign" && order.status_timeline == "Time/Date Signing Set" && order.notary_id.present?
      @rts_orders       << order if (order.status == "Refuse To Sign" || order.cancel_order != '' ||  order.admin_order_cancel != '' )&& order.notary_id.present? 
      @signed_orders    << order if ["signing_completed", "Signing Completed"].include?(order.status_timeline) && order.notary_id.present?
      @paid_orders      << order if ["notary_paid_full", "Notary Paid in Full"].include?(order.status_timeline) && order.notary_id.present?
    end

    per_page = 20
    @orders           = @orders.paginate :page => params[:page], :per_page => per_page
    @pending_orders   = @pending_orders.paginate :page => params[:page], :per_page => per_page
    @assigned_orders  = @assigned_orders.paginate :page => params[:page], :per_page => per_page
    @confirmed_orders = @confirmed_orders.paginate :page => params[:page], :per_page => per_page
    @rts_orders       = @rts_orders.paginate :page => params[:page], :per_page => per_page
    @signed_orders    = @signed_orders.paginate :page => params[:page], :per_page => per_page
    @paid_orders      = @paid_orders.paginate :page => params[:page], :per_page => per_page
  end

   def pending_orders
     @notary = Notary.find_by_user_id(self.current_user.id)
     multiple_notary = MultipleNotary.find_all_by_notary_id(@notary,:conditions => ["status ='not filled'"]).collect{|i|i.order_id}

    if params[:notification]
      @multi_notary=MultipleNotary.find_by_notary_id_and_order_id(params[:notary_id],params[:order_id])
      @multi_notary.notification=1
      @multi_notary.save
    end

     sort_by = {
         "Borrower Name" => "borrower_1_last_name ASC",
         "Signing Date" => "signing_date ASC",
         "Escrow Number" => "loan_number ASC",
         "Date Created" => "created_at DESC",
     }

     @filter = sort_by[params[:filter]] rescue nil
     @filter ||= "borrower_1_last_name ASC"

     @orders = Order.find(:all, :conditions => ["id IN (?) AND status = 'need notary'", multiple_notary ], :order => @filter)
      if request.xhr?
       respond_to do |format|
         format.js
        end
      end

  end

  def history
    @notary = Notary.find_by_user_id(self.current_user.id)
    sort_by = {
        "Borrower Name" => "borrower_1_last_name ASC",
        "Signing Date" => "signing_date ASC",
        "Escrow Number" => "loan_number ASC",
        "Date Created" => "created_at DESC",
    }
    per_page = 20
    filter = sort_by[params[:filter]] rescue nil
    filter ||= "borrower_1_last_name ASC"
    @orders = Order.find(:all, :conditions => ["status!=? AND notary_id=?", 'closed', @notary.id], :order => filter)
     refused_to_sign_orders    = []
     paid_orders      = []

    @orders.each do |order|
      refused_to_sign_orders       << order if order.status == "Refuse To Sign" && order.notary_id.present?
      paid_orders      << order if ["notary_paid_full", "Notary Paid in Full"].include?(order.status_timeline) && order.notary_id.present?
    end
    @refused_to_sign_orders = refused_to_sign_orders.paginate :page => params[:page], :per_page => per_page
    @paid_orders = paid_orders.paginate :page => params[:page], :per_page => per_page


  end

  def order_detail
    @order = Order.find(params[:order_id])
    @client = Client.find(@order.client_id)

    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end

    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
    end

    if @agent!=nil
      @agent_company_name  = @agent.company_name
      @agent_broker_name   = @agent.broker_name
      @agent_address       = @agent.address
      @agent_city          = @agent.city
      @agent_state         = @agent.state
      @agent_zip_code      = @agent.zip_code
      @agent_home_phone    = @agent.home_phone

      if @agent_home_phone.size==0
        @agent_home_phone = "Not Provided"
      end
      @agent_home_extension = @agent.home_extension

      if @agent_home_extension.size==0
        @agent_home_extension = "Not Provided"
      end
      @agent_mobile_phone  = @agent.mobile_phone

      if @agent_mobile_phone.size==0
        @agent_mobile_phone = "Not Provided"
      end
    end

    if @notary!=nil
      @notary_first_name = @order.notary.first_name
      @notary_last_name  = @order.notary.last_name
      @notary_id   = @order.notary.id
      @notary_day_phone = @order.notary.day_phone

      if @notary_day_phone.size==0
        @notary_day_phone = "Not Provided"
      end

      @notary_evening_phone  = @order.notary.evening_phone

      if @notary_evening_phone.size==0
        @notary_evening_phone = "Not Provided"
      end

      @notary_mobile_phone = @order.notary.mobile_phone

      if @notary_mobile_phone.size==0
        @notary_mobile_phone = "Not Provided"
      end

      @notary_work_phone = @order.notary.work_phone

      if @notary_work_phone.size==0
        @notary_work_phone = "Not Provided"
      end
      @notary_user_email = @order.notary.user.email
      @notary_user_user_password   = @order.notary.user.user_password
      @notary_billing_payable_to = @order.notary.billing_payable_to
      @notary_billing_deliver_address = @order.notary.billing_deliver_address
      @notary_billing_deliver_city  = @order.notary.billing_deliver_city
      @notary_billing_deliver_state = @order.notary.billing_deliver_state
      @notary_billing_deliver_zip_code = @order.notary.billing_deliver_zip_code
    end

  end
    
    def details
    @order = Order.find(params[:id])
    content = @order.notary_invoice(@order)
    send_data(content.to_pdf, :filename => "customer_invoice#{@order.id}.pdf", :disposition => 'inline', :type => 'application/pdf')
    end
 

  def resend_confirmation
    @order = Order.find(params[:id])
    @notary = Notary.find(@order.notary_id)
    notary_email = User.find(@notary.user_id)
    notary_email = notary_email.email

    Notifier.deliver_notary_order_confirmation(@order, notary_email)
    redirect_to :action => 'details', :id => @order.id
    flash[:notice] ="Order email confirmation re-sent."
  end

  def complete_order
    @order = Order.find(params[:id])
    if params[:order][:return_account_number]
      client = Client.find_by_id(@order.client_id)
      agent = Agent.find(@order.agent_id).email if !@order.agent_id.blank?
      client_email = User.find(client.user_id).email
      status_log = @order.status_log.to_s + "#Signing Completed: #{Time.now.strftime('%m/%d/%y - %H:%M %p')} - #{@order.notary.first_name} Notary"
      @order.update_attributes(:status_timeline => "Signing Completed", :status_log => status_log)
      @order.update_attribute(:return_account_number, params[:order][:return_account_number])
      @order.update_attribute(:return_shipping_courier, params[:order][:return_shipping_courier])
      @order.update_attribute(:signing_comments, params[:order][:signing_comments])
      if @order.status_timeline=="Signing Completed"
        Notifier.deliver_mail_to_client_for_signing_completed(@order, client_email)
        Notifier.deliver_mail_to_agent_for_signing_completed(@order, agent) if !@order.agent_id.blank?
      end
    elsif params[:order][:closed_comments]
      @order.update_attribute(:status, "closed")
      @order.update_attribute(:closed_carrier, params[:order][:closed_carrier])
      @order.update_attribute(:closed_tracking_number, params[:order][:closed_tracking_number])
      @order.update_attribute(:closed_comments, params[:order][:closed_comments])
      @order.update_attribute(:feedback, "needed")

      @client = Client.find(@order.client_id)
      client_email = User.find(@client.user_id)
      client_email = client_email.email

      @notary = Notary.find(@order.notary_id)
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email


      Notifier.deliver_client_order_completed(@order, client_email)
      Notifier.deliver_notary_order_completed(@order, notary_email)


      flash[:notice] = "The order number #{@order.id} has been closed and can now be found under the history tab"
    end
    if params[:redirect_to].present?
      redirect_to params[:redirect_to]
    else
      redirect_to :action => "index"
    end

   end

  def edit
    @client = Client.find_by_user_id(self.current_user.id)
    @order = Order.find(params[:id])
    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end
  end

  def add_notes
    @notes = Notes.new
    @notes.order_id = params[:id]
    @notes.user_id = self.current_user.id
    @notes.notes = params["notes"][:notes]
				# set require_attention to display the order in attention tab
				@notes.require_attention = true
    @notes.save
    if params[:redirect_to].present?
      redirect_to params[:redirect_to]
    else
      redirect_to(:action => 'index')
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.update_attributes(params[:order])

   # redirect_to :action => "details", :id => params[:id]
    if params[:redirect_to].present?
      redirect_to params[:redirect_to]
    else
      redirect_to :action => "index"
    end

    flash[:notice] = "Your order has been updated"
  end

  def add_notes_from_history
    @notes = Notes.new
    @notes.order_id = params[:id]
    @notes.user_id = self.current_user.id
    @notes.notes = params["notes"][:notes]
    @notes.save
    redirect_to(:action => 'history')
  end

  def re_confirmation
    @order = Order.find(params[:id])
    @order.update_attributes(:re_confirmation => 1)
    @client = Client.find(@order.client_id)
    client_email = User.find(@client.user_id)
    client_email = client_email.email

    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end

    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
    end


    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
      if @agent!=nil
        if @agent.notify_agent == "Yes"
          agent_email = @agent.email
          Notifier.deliver_agent_order_confirmation(@order, @agent, @notary, agent_email) #agent_email
        end
      end
    end
    Notifier.deliver_client_order_confirmation(@order,@agent,@notary, client_email) #client_email


    if @order.notary_id
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email
      Notifier.deliver_notary_order_confirmation(@order, @agent, @notary, notary_email) #notary_email
    end
    redirect_to :action => 'index'
  end

  def download
    @paths = params[:path].split("\?")
    @path=RAILS_ROOT+"/public"+@paths[0]
    send_file("#{@path}", :type => 'all')
  end

  def deny_order
    notary = Notary.find_by_user_id(self.current_user.id)
    order=Order.find_by_id(params[:id])
    mul_notaries = MultipleNotary.find_by_notary_id_and_order_id(notary.id, params[:id])
    mul_notaries.update_attributes(:status => "order denied")
    order.update_attributes(:status => "order denied")
    order.save
    redirect_to :action => 'pending_orders'
    flash[:notice] = "Order ##{order.id}was declined by Notary(you)"

  end

  def accept_order
    notary = Notary.find_by_user_id(self.current_user.id)
    mul_notaries = MultipleNotary.find_by_notary_id_and_order_id(notary.id, params[:id])
    mul_notaries.update_attributes(:accept_status => "1")
    order=Order.find_by_id(params[:id])
    signing_fee = order.client.customer_fee
				status_log = @order.status_log.to_s + "#Notary Assigned: #{Time.now.strftime('%m/%d/%y - %H:%M %p')} - #{notary.first_name} Notary"
    order.update_attributes(:status => "filled", :status_timeline=> "Notary Assigned", :notary_id => notary.id, :signing_fee => signing_fee, :customer_fee => signing_fee, :status_log => status_log)
    order.save
    render :js => "window.location = '#{request.referer}'"
    flash[:notice] = "You have been assigned this Order. Details in Open Orders"
  end

  def send_mail_for_date_confirmed
    @order = Order.find_by_id(params[:id])
    if params[:display] == "1"
      @order.update_attributes(:status_timeline => "Time/Date Signing Set")
    elsif params[:display] == "2"
      @order.update_attributes(:status_timeline => "Documents Received by Notary")
    else
      @order.update_attributes(:status_timeline => "Signing Completed")
    end
    if @order
      client = Client.find_by_id(@order.client_id)

      agent = Agent.find(@order.agent_id).email if !@order.agent_id.blank?
      client_email = User.find(client.user_id).email


      if @order.status_timeline == "Time/Date Signing Set"
								status_log = @order.status_log.to_s + "#Appt Confirmed: #{Time.now.strftime('%m/%d/%y - %H:%M %p')} - #{@order.notary.first_name} Notary"
								@order.update_attributes(:status_log => status_log)
        Notifier.deliver_mail_to_client_for_date_confirmed(@order, client_email)
        Notifier.deliver_mail_to_agent_for_date_confirmed(@order, agent) if !@order.agent_id.blank?

      elsif @order.status_timeline == "Documents Received by Notary"
        Notifier.deliver_mail_to_client_for_documents_received_notary(@order, client_email)
        Notifier.deliver_mail_to_agent_for_documents_received_notary(@order, agent) if !@order.agent_id.blank?
        #elsif @order.status_timeline == "Signing Completed"

        #Notifier.deliver_mail_to_client_for_signing_completed(@order, client_email )
        #Notifier.deliver_mail_to_agent_for_signing_completed(@order,agent) if !@order.agent_id.blank?
      end


      if  params[:display]=="3"
        redirect_to :controller => 'notary/orders', :action => 'index'
      else
        render :js => "window.location = '#{request.referer}'"
      end

    end
  end

  def refuse_to_sign
    @order = Order.find_by_id(params[:id])
    if @order.update_attributes(:status => "Refuse To Sign")
      render :js => "window.location = '#{request.protocol}#{request.env['HTTP_HOST']}/notary/orders?tab=tabs5'"
    else
      render :js => "window.location = '#{params[:redirect_to]}'"
    end
  end

end
