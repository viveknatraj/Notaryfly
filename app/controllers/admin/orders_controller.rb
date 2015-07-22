require 'total_apps'
class Admin::OrdersController < ApplicationController
  layout "adminpanel"
  include Admin::OrdersHelper
  helper :all

def order_update
  @order=Order.find_by_id(params[:order_id])
		status_log = @order.status_log.to_s + "#Moved to Order History: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} -#{session[:admin_user]} Admin"
  @order.update_attributes(:move_to_order_history_by_admin => true)
  flash[:notice] = "Successfully Order moved to order history"
  redirect_to(:controller => "admin/orders", :action => :open_order, :tab => params[:tab])
end
def move_to_paid
  @order=Order.find_by_id(params[:order_id])
  @order.update_attributes(:status_timeline => 'Paid')
  flash[:notice] = "Successfully Order moved to paid orders"
  redirect_to(:controller => "admin/orders", :action => :open_order, :tab => params[:tab])
end

  def index
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    # @orders = Order.find(:all,:conditions=>["status='closed'"])
    #@orders = Order.paginate :page => params[:page], :conditions => ["status='closed'"]
    if params[:per_page] == "All"
      #@orders = Order.find(:all,:conditions=>["status='closed' AND admin_order_cancel IS NULL AND move_to_order_history_by_admin = false"])
      @orders = Order.find(:all,:conditions=>["(status_timeline='Paid' or (status_timeline='Notary Paid in Full' and payment = false ) or (status_timeline='Executive Paid in Full' and executive_payment = true )) AND admin_order_cancel IS NULL AND move_to_order_history_by_admin = false and payment = false"], :order => 'updated_at desc')
    else
      #@orders = Order.find(:all,:conditions=>["status='closed' AND admin_order_cancel IS NULL AND move_to_order_history_by_admin = false"]).paginate(:page => params[:page], :per_page => params[:per_page] || 25)
      @orders = Order.find(:all,:conditions=>["(status_timeline='Paid' or (status_timeline='Notary Paid in Full' and notary_payment = true ) or (status_timeline='Executive Paid in Full' and executive_payment = true )) AND admin_order_cancel IS NULL AND move_to_order_history_by_admin = false and payment = false"], :order => 'updated_at desc').paginate(:page => params[:page], :per_page => params[:per_page] || 25)
    end
    @feedback_average=[]
    @orders.each do |f|
      @feedback=OrderFeedback.find_all_by_order_id(f.id)
      if @feedback!=[]
        @feedback.each do |feedback|
          if feedback.accuracy!=nil
            @accuracy=feedback.accuracy.to_f
          else
            @accuracy=0
          end
          if feedback.communication!=nil
            @communication=feedback.communication.to_f
          else
            @communication=0
          end
          if feedback.punctuality!=nil
            @punctuality=feedback.punctuality.to_f
          else
            @punctuality=0
          end
          if feedback.fees!=nil
            @fees=feedback.fees.to_f
          else
            @fees=0
          end
          if feedback.professionalism!=nil
            @professionalism=feedback.professionalism.to_f
          else
            @professionalism=0
          end
          @feedback_avg=(@accuracy+@communication+@punctuality+@fees+@professionalism)/5
          @feedback_average<<@feedback_avg
        end

      else
        @feedback_average<<0.0
      end
    end
       if request.xhr?
         render :update do |page|
         page.replace_html  'completed_orders_index', :partial => 'update_index'
         end
      end
  end

  def open_order
    redirect_to session[:url] if session[:admin_user] == nil

    @orders = Order.find(:all, :conditions => ["status!='closed' AND admin_order_cancel IS NULL AND move_to_order_history_by_admin = false and cancel_order IS NULL"], :order => "updated_at DESC")
    @awaiting_notary_orders = []
    @notary_assigned_orders = []
    @appt_confirmed_orders  = []
    @attention_orders       = []
    @refuse_to_sign_orders  = []
    @signed_orders_orders   = []
    @paid_orders            = []
    @completed_orders       = []

    @orders.each do |order|
      @awaiting_notary_orders << order if order.status == "need notary" && order.move_to_order_history_by_admin == false
      @notary_assigned_orders << order if order.status == "filled" && order.status_timeline == "Notary Assigned" && order.move_to_order_history_by_admin == false
      @appt_confirmed_orders  << order if order.status != "Refuse To Sign" && order.status_timeline == "Time/Date Signing Set" && order.notary_id.present? && order.move_to_order_history_by_admin == false
      #@attention_orders       << order if order.status != "Refuse To Sign" && order.status_timeline == "Documents Received by Notary" && order.notary_id.present?
      #@refuse_to_sign_orders  << order if order.status == "Refuse To Sign" && order.notary_id.present?
      @signed_orders_orders   << order if ["signing_completed", "Signing Completed"].include?(order.status_timeline) && order.notary_id.present? && order.move_to_order_history_by_admin == false
      @completed_orders       << order if ["Order Completed"].include?(order.status_timeline) && order.notary_id.present? && order.move_to_order_history_by_admin == false
      @paid_orders            << order if ['Paid', 'Notary Paid in Full', 'Executive Paid in Full'].include?(order.status_timeline) && order.notary_id.present? && order.move_to_order_history_by_admin == false
    end
    
      #attention_orders = Order.find_by_sql("select o.id as order_id from orders o LEFT JOIN messages m ON o.id=m.order_id LEFT JOIN notes n ON o.id=n.order_id where o.status != 'Refuse To Sign' AND o.status_timeline ='Documents Received by Notary' AND move_to_order_history_by_admin=false AND n.require_attention = true and o.notary_id IS NOT NULL")
      attention_orders = Order.find_by_sql("select o.id as order_id from orders o LEFT JOIN messages m ON o.id=m.order_id LEFT JOIN notes n ON o.id=n.order_id where move_to_order_history_by_admin=false AND n.require_attention = true and o.notary_id IS NOT NULL")
      attention_orders.each do |order|
        @attention_orders << Order.find(order.order_id)
       end
        

    per_page = 20
    @orders = @orders.paginate :page => params[:page], :per_page => per_page
    @awaiting_notary_orders = @awaiting_notary_orders.paginate :page => params[:page], :per_page => per_page
    @notary_assigned_orders = @notary_assigned_orders.paginate :page => params[:page], :per_page => per_page
    @appt_confirmed_orders  = @appt_confirmed_orders.paginate :page => params[:page], :per_page => per_page
    @attention_orders       = @attention_orders.paginate :page => params[:page], :per_page => per_page
    #@refuse_to_sign_orders  = @refuse_to_sign_orders.paginate :page => params[:page], :per_page => per_page
    @refuse_to_sign_orders  = Order.paginate :page => params[:page], :per_page => per_page, :conditions => ["(cancel_order IS NOT NULL  or admin_order_cancel IS NOT NULL ) AND move_to_order_history_by_admin=false"], :order => "updated_at DESC"
    @signed_orders_orders   = @signed_orders_orders.paginate :page => params[:page], :per_page => per_page
    @completed_orders       = @completed_orders.paginate :page => params[:page], :per_page => per_page
    @paid_orders            = @paid_orders.paginate :page => params[:page], :per_page => per_page

    params[:tab] = 'tabs1' unless params[:tab].present?

    if request.xhr?
      render :update do |page|
        page << "alert('Notary assigned');"
        page << "window.location = '/admin/orders/open_order?tab=#{params[:tab]}'"
      end
    end
  end

  def pending_order
    @ex=[]
    if session[:admin_user] == nil
      redirect_to session[:url]
    end

    @orders = Order.paginate :page => params[:page], :conditions => ["status!='filled'AND status!='closed'"]
#@order_id=@orders.id

#raise @ex.inspect
  end
  
  def order_history
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    paid_orders            = []
    per_page = 20
    @orders = Order.find(:all, :conditions => ["status!='closed' and move_to_order_history_by_admin = true"], :order => "updated_at DESC")
    @orders.each do |order|
      paid_orders            << order if ['Paid', "notary_paid_full", "Notary Paid in Full", 'Executive Paid in Full'].include?(order.status_timeline) && order.notary_id.present? && order.move_to_order_history_by_admin == false && order.payment == true
    end
     @history_paid_orders            = paid_orders.paginate :page => params[:page], :per_page => per_page
     @history_cancelled_orders= Order.paginate :page => params[:page], :conditions => ["cancel_order IS NOT NULL AND move_to_order_history_by_admin=true"]
   end
   
   def order_history_paid
    if session[:admin_user] == nil 
      redirect_to session[:url]
    end
    paid_orders            = []
    per_page = 20
    @orders = Order.find(:all, :conditions => ["status!='closed'"], :order => "updated_at DESC").paginate :page => params[:page], :per_page => per_page
    #@orders = Order.find(:all, :conditions => ["status!='closed' and move_to_order_history_by_admin = true"], :order => "updated_at DESC").paginate :page => params[:page], :per_page => per_page
    @orders.each do |order|
      paid_orders << order if ["Paid", "notary_paid_full", "Notary Paid in Full", 'Executive Paid in Full'].include?(order.status_timeline) && order.notary_id.present? && order.move_to_order_history_by_admin == false && order.payment == true
    end
    @history_paid_orders = paid_orders.paginate :page => params[:page], :per_page => per_page
    if request.xhr?
        render :update do |page|
        page.replace_html  'orderhis_paid', :partial => 'update_orderhis_paid'
        end
     end
   end
   
   def order_history_cancelled
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    per_page = 20
    @history_cancelled_orders= Order.paginate :page => params[:page], :conditions => ["cancel_order IS NOT NULL AND move_to_order_history_by_admin=true"]
    @orders = Order.find(:all, :conditions => ["status!='closed'"], :order => "updated_at DESC").paginate :page => params[:page], :per_page => per_page
    if request.xhr?
     render :update do |page|
         page.replace_html  'orderhis_paid', :partial => 'update_order_history_cancelled'
     end
    end
   end
   
  

  def cancelled_order
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    @orders = Order.paginate :page => params[:page], :conditions => ["cancel_order IS NOT NULL"]
  end

  def approve_to_cancel_message
#    if session[:admin_user] == nil
#      redirect_to session[:url]
#    end

    @order = Order.find_by_id(params[:orderid])

    @order.update_attribute(:admin_order_cancel, params[:admin_order_cancel])
    @order.update_attribute(:admin_order_cancel_date, Date.today)
    #@order.update_attribute(:admin_cancel_approve,1)
    @order.save
    #      if !@order.cancel_order.blank?
    #        client = Client.find_by_id(@order.client_id)
    #        notary = Notary.find_by_id(@order.notary_id)
    #        agent =  Agent.find(@order.agent_id).email if !@order.agent_id.blank?
    #        notary_email = User.find(notary.user_id).email
    #        client_email = User.find(client.user_id).email
    #
    #        Notifier.deliver_cancel_order_for_client(@order,client_email)
    #        Notifier.deliver_cancel_order_for_notary(@order,notary_email)
    #        Notifier.deliver_cancel_order_for_agent(@order,agent) if !@order.agent_id.blank?
    #        Notifier.deliver_cancel_order_for_admin(@order)
    #      end
    #redirect_to :controller => 'admin/orders', :action => 'cancelled_order', :popup_order_id => @order.id
     redirect_to(request.referrer)
  end

  def approve_to_cancel
    @order=Order.find_by_id(params[:id])
    @user_client=Client.find_by_id(@order.client_id).user
    #raise params[:id].inspect                    # 0 notes approved pending
    if params[:approve]=='1'
      @order.update_attribute(:admin_approve, 1) #approved yes

    elsif params[:approve]=='2'
      @order.update_attribute(:admin_approve, 1) #approved yes

      travel_fee=@order.travel_fee.to_f+50.0

      @order.update_attribute(:travel_fee, travel_fee)
    elsif params[:approve]=='3'

      @user_client.update_attribute(:suspend, 1)
      @order.update_attribute(:admin_approve, 2) #approved no
      @user_client.save

    end
    @order.save

    if params[:approve]=='1'
      Notifier.deliver_approve_cancel_without_travel_fee(@order, @user_client.email)
    elsif params[:approve]=='2'
      Notifier.deliver_approve_cancel_with_travel_fee(@order, @user_client.email)
    elsif params[:approve]=='3'
      Notifier.deliver_deny_cancel(@order, @user_client.email)
    else

    end
    redirect_to :controller => 'admin/orders', :action => 'open_order'

  end

  def edit_travel_fee

    @orders=Order.find(params[:order_id])
    @orders.update_attribute(:travel_fee, params[:travel_fee].to_f)
    redirect_to :back

  end

  def edit_notaryother_fee

    @notary=Notary.find(params[:notary_id])
    @notary.update_attribute(:other_fee, params[:notaryother_fee].to_f)
    redirect_to :back

  end
  def edit_total_revenue
    @orders=Order.find(params[:order_id])
    @orders.update_attribute(:total_revenue, params[:total_revenue].to_f)
    redirect_to :back

  end

  def accounting
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    @orders = Order.paginate :page => params[:page], :conditions => ["status!='closed'"]
    if request.xhr?
         render :update do |page|
         page.replace_html  'completed_orders_index', :partial => 'update_accounting'
         end
      end
  end
  
  def order_history_accounting
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    @orders = Order.paginate :page => params[:page], :conditions => ["status!='closed'"]
      if request.xhr?
         render :update do |page|
         page.replace_html  'orderhis_paid', :partial => 'update_order_history_accounting'
         end
      end
  end

  def destroy_notary_feedback
    if params[:notary_id]!=nil
      @order_feedback=OrderFeedback.find(:all, :conditions => ["order_id=? AND notary_id=?", params[:id], params[:notary_id]])
    end
    if @order_feedback!=[]
      @order_feedback.each do |order|

        order.update_attributes(:response_from_notary => nil)
        order.update_attributes(:accuracy => nil)
        order.update_attributes(:communication => nil)
        order.update_attributes(:punctuality => nil)
        order.update_attributes(:professionalism => nil)
        order.update_attributes(:fees => nil)
        order.save
      end
    end

    redirect_to :action => 'index', :page => params[:page]
  end

  def suspend_update
    @user=User.find_by_id(params[:id])

    if @user.suspend == 'nil' || @user.suspend == 1
      @user.update_attribute("suspend", 0)
    else
      @user.update_attribute("suspend", 1)
    end
  end

  def download
    @paths = params[:path].split("\?")
    @path=RAILS_ROOT+"/public"+@paths[0]
    send_file("#{@path}", :type => 'all')
  end

  def invoice_details
    @order = Order.find(params[:id])
    @client = Client.find(@order.client_id)

    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end

    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
    end

    if @agent!=nil
      @agent_company_name = @agent.company_name
      @agent_broker_name = @agent.broker_name
      @agent_address = @agent.address
      @agent_city = @agent.city
      @agent_state = @agent.state
      @agent_zip_code = @agent.zip_code
      @agent_home_phone = @agent.home_phone

      if @agent_home_phone.size==0
        @agent_home_phone = "Not Provided"
      end
      @agent_home_extension = @agent.home_extension

      if @agent_home_extension.size==0
        @agent_home_extension = "Not Provided"
      end
      @agent_mobile_phone = @agent.mobile_phone

      if @agent_mobile_phone.size==0
        @agent_mobile_phone = "Not Provided"
      end
    end

    if @notary!=nil
      @notary_first_name = @order.notary.first_name
      @notary_last_name = @order.notary.last_name
      @notary_id = @order.notary.id
      @notary_day_phone = @order.notary.day_phone

      if @notary_day_phone.size==0
        @notary_day_phone = "Not Provided"
      end

      @notary_evening_phone = @order.notary.evening_phone

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
      @notary_user_user_password = @order.notary.user.user_password
      @notary_billing_payable_to = @order.notary.billing_payable_to
      @notary_billing_deliver_address = @order.notary.billing_deliver_address
      @notary_billing_deliver_city = @order.notary.billing_deliver_city
      @notary_billing_deliver_state = @order.notary.billing_deliver_state
      @notary_billing_deliver_zip_code = @order.notary.billing_deliver_zip_code
    end

  end

  # update executive action to update the client executive mappings in database
  def update_executive
    if (params[:order_id].blank?)
      render :text => 'Invalid order'
      return
    end
    @order=Order.find(params[:order_id])
    # validating parameters
    if params[:executives].blank?
      render :text => "Error: Please select atleast one executive"
      return
    else
      params[:executives]=params[:executives]["0"]
      count=0
      # removing all old order executive records for order
      if @order.order_executives.present? and params[:executives]!=@order.order_executives.map(&:executive_id)
        @order.order_executives.delete_all
      end
      # need to create new order executive records in database by mapping executive and order
      params[:executives].each { |e|
        ce=OrderExecutive.create(:order_id => @order.id, :executive_id => e)
        count+=1
      }
      msg="#{count} executive(s) mapped to order ##{@order.id}"
      render :text => msg
      #redirect_to :action => 'index', :msg => msg
    end
  end

  # new function to process payments
  def do_payment
    unless params[:order_ids].present?
      flash[:error]='Please select any one order'
      redirect_to :back
    else
      order_list=params[:order_ids]
			# need to display only first order details
      #@orders=Order.all(:conditions => [" id in (?)", order_list])
			first_order = Order.find(order_list.first)
      @orders ||= []
      @header_name = params['notary_payment'] ? 'Notary' : 'Executive'
      if params['notary_payment'] && first_order.status_timeline != 'Notary Paid in Full'
								@notary = first_order.notary
        @actual_name = "#{@notary.first_name} #{@notary.last_name}"
        #@orders=Order.all(:conditions => {:notary_id => first_order.notary_id, :status => 'closed'})
        @orders=Order.all(:conditions => {:notary_id => first_order.notary_id, :status_timeline => 'Paid'})
        @total_fee = ( @notary.fee.to_i + @notary.other_fee.to_i ) * @orders.count
        @total_fee = @total_fee.to_i
      elsif params['executive_payment']  && first_order.status_timeline != 'Executive Paid in Full'
        # saving executive ids into order record and it will be removed once
        # payment made
        @executives = first_order.client.client_executives
        unless @executives.present?                                                                                                   
          flash[:error]="No executives mapped"
          redirect_to :back
				else
          if first_order.executive_ids.empty?
             first_order.executive_ids = @executives.map(&:executive_id)
             first_order.save
          else
            @executives = ClientExecutive.all(:conditions => ["executive_id in (?) and client_id = #{first_order.client.id}", first_order.executive_ids])
          end
          @orders = {}
          @executives.each do |e|
            @orders[e.executive_id] = {:orders_list => [], :total_fee => 0, :name => e.executive.name}
            @orders[e.executive_id][:orders_list] = Order.all(:conditions=>["(status_timeline='Paid' or (status_timeline='Notary Paid in Full' and payment = false )) and client_id=#{e.client_id}"])
            #@orders[e.executive_id][:orders_list] = Order.all(:conditions => {:client_id => e.client_id, :status => 'closed'})
            unless e.share_percentage.present?
              @orders[e.executive_id][:total_fee] = e.share_value * @orders[e.executive_id][:orders_list].count 
            else
              @orders[e.executive_id][:orders_list].each {|order|
                @orders[e.executive_id][:total_fee] += ( order.client.customer_fee.to_i / 100.0 ) * e.share_percentage
              }
            end
          end
          render 'do_executive_payment'
          end
      else
        flash[:error]="Already #{@header_name} payment done"
        redirect_to :back
      end
    end
    # processing each values
    #render :text => "Params passed are: #{params.inspect}\nOrder: #{@orders.count}"
  end

  def make_payment
    order_list=params[:order_ids]
    @orders=Order.all(:conditions => [" id in (?)", order_list])
    # initial payment parameters
    gw = GwApi.new()

    gw.setLogin(PaymentLoginName, PaymentLoginPassword);

    gw.setBilling("John", "Smith", "Acme, Inc.", "123 Main St", "Suite 200", "Beverly Hills",
                  "CA", "90210", "US", "555-555-5555", "555-555-5556", "support@example.com",
                  "www.example.com")

    gw.setShipping("Mary", "Smith", "na", "124 Shipping Main St", "Suite Ship", "Beverly Hills",
                   "CA", "90210", "US", "support@example.com")

    gw.setOrder("1234", "Big Order", 1, 2, "PO1234", "65.192.14.10")

    # following is a code to make payment for each order
    success_count=0
    @orders.each { |o|
      unless o.payment
        notary=o.notary
        logger.info " ----------------------------------------------------------- "
        logger.info "PAYMENT DETAILS of ORDER: #{o.id}"
        #doCredit(amount, account_no, routing_no, account_type, account_holder_type, check_name )
        r = gw.doCredit(o.notary_fee, notary.account, notary.routing, notary.account_type, notary.account_holder_type, notary.name)
        myResponses = gw.getResponses

        logger.info "RESPONSE of payment:#{myResponses['response']}"

        if (myResponses['response'] == '1')
          logger.info "Notary #{notary.id} payment successful"
          success_count+=1
          # updating order payment details
          o.payment_date=Time.now
          o.payment=true
          o.save
        elsif (myResponses['response'] == '2')
          logger.info "Notary #{notary.id} payment declined.Error: #{myResponses['responsetext']}"
        elsif (myResponses['response'] == '3')
          logger.info "Notary #{notary.id} payment error.Error: #{myResponses['responsetext']}"
        end
        executives=o.executives
        if executives.present?
          executive_share_value=o.client.client_executives.first.share_value
          executive_share_value=(o.signing_fee*o.client.client_executives.first.share_percentage)/100.0 unless executive_share_value.present?

          executives.each { |e|
            logger.info "Executive Payment"
            r = gw.doCredit(executive_share_value, e.account_number, e.routing_number, e.account_type, e.account_holder_type, e.account_name)
            myResponses = gw.getResponses

            logger.info "RESPONSE of payment:#{myResponses['response']}"

            if (myResponses['response'] == '1')
              logger.info "Executive #{e.id} payment successful"
              # updating order payment details
              o.payment_date=Time.now
              o.payment=true
              o.save
            elsif (myResponses['response'] == '2')
              logger.info "Notary #{notary.id} payment declined.Error: #{myResponses['responsetext']}"
            elsif (myResponses['response'] == '3')
              logger.info "Notary #{notary.id} payment error.Error: #{myResponses['responsetext']}"
            end
          }
        end
        logger.info " ----------------------------------------------------------- "
      end
    }
    if success_count != @orders.count
      failed_count=@orders.count - success_count
      flash[:error]="Payment failed for #{failed_count} orders"
    else
      flash[:notice]="Payment made successfully for #{success_count} orders"
    end
    redirect_to :action => :index
  end

  def new_payment
    payment_to = params[:type]
    payee_id = params[:type_id]
		payment_due = params[:due]
		if payment_to == 'notary'
      notary = Notary.find(payee_id)
			account_no = notary.account
			routing_no = notary.routing
			account_type = notary.account_type
			account_holder_type = notary.account_holder_type
			check_name = notary.name
		else
		  executive = Executive.find(payee_id)
			account_no = executive.account_number
			routing_no = executive.routing_number
			account_type = executive.account_type
			account_holder_type = executive.account_holder_type
			check_name = executive.account_name
		end
    @orders=Order.all(:conditions => [" id in (?)", params[:order_ids]])
    if @orders.present?
    first_order = @orders[0]
    # initial payment parameters
    gw = GwApi.new()

    gw.setLogin(PaymentLoginName, PaymentLoginPassword);

    gw.setBilling("John", "Smith", "Acme, Inc.", "123 Main St", "Suite 200", "Beverly Hills",
                  "CA", "90210", "US", "555-555-5555", "555-555-5556", "support@example.com",
                  "www.example.com")

    gw.setShipping("Mary", "Smith", "na", "124 Shipping Main St", "Suite Ship", "Beverly Hills",
                   "CA", "90210", "US", "support@example.com")

    order_id = payment_to == 'notary' ? first_order.id : executive.id
    gw.setOrder(order_id.to_s, check_name, account_no, routing_no, "PO1234", "65.192.14.10")

    #doCredit(amount, account_no, routing_no, account_type, account_holder_type, check_name )
    r = gw.doCredit(payment_due, account_no.to_s, routing_no.to_s, account_type, account_holder_type, check_name)
    myResponses = gw.getResponses


    if (myResponses['response'] == '1')
      logger.info "#{payment_to.capitalize} #{payee_id} payment successful"
      # updating order payment details
		  if payment_to == 'notary'
			  @orders.each{|o|
          o.notary_payment_date=Time.now
          o.notary_payment=true
          o.status_timeline = 'Notary Paid in Full'
          o.payment = true if o.executive_payment == true
          o.save
			  }
      flash[:notice]="Payment made successfully for Notary: #{check_name}"
			else
        executive_ids = first_order.executive_ids
        executive_ids.delete(executive.id)
        first_order.executive_ids = executive_ids
        first_order.executive_payment_date=Time.now
        first_order.save
        first_order.reload
			  @orders.each{|o|
          if first_order.order_executives.empty?
            o.status_timeline = 'Executive Paid in Full' 
          else
            o.executive_payment_date=Time.now
            o.executive_payment=true
            o.payment = true if o.notary_payment == true
          end
          o.save
			  }
      flash[:notice]="Payment made successfully for Executive: #{check_name}"
			end
    elsif (myResponses['response'] == '2')
      logger.info "#{payment_to.capitalize} '#{check_name}' payment declined.Error: #{myResponses['responsetext']}"
      flash[:error] = "#{payment_to.capitalize} '#{check_name}' payment declined.Error: #{myResponses['responsetext']}"
    elsif (myResponses['response'] == '3')
      logger.info "#{payment_to.capitalize} '#{check_name}' payment failed.Error: #{myResponses['responsetext']}"
      flash[:error] = "#{payment_to.capitalize} '#{check_name}' payment failed.Error: #{myResponses['responsetext']}"
		else
      logger.info "#{payment_to.capitalize} '#{check_name}' payment failed.Error: #{r}"
      flash[:error] = "#{payment_to.capitalize} '#{check_name}' payment failed. Error: #{r}"
    end
    else
      flash[:error] = "No orders mapped"
    end
    redirect_to :action => :index
  end

  def find_notary
    @order = Order.find(params[:id], :conditions => ["status = ?", "need notary"])
    @miles = 10
    @dropdown_language = "display:none;"
    @check_additional_language = ""
    @check_attorney = ""
    @check_title_producer = ""
    @check_email_capable = ""
    @check_reverse_mortgage = ""
    @check_life_settlement = ""
    @check_enotification = ""
    @selected_lang = ""
    @query_str = ""

    #  Notary.distance_between(from, to)
    unless params[:notary_search]
      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true",:order=>"distance asc" )
    else
      if params[:notary_search][:additional_language] == "1"
        additional_language = "Yes"
        @query_str = @query_str+"AND bilingual='Yes' "
        language = params[:order]['required_language']
        @selected_lang = language
        @check_additional_language = "checked"
        @dropdown_language = "display:inline;"
      else
        additional_language = ""
      end

      if params[:notary_search][:attorney] == "1"
        attorney = "1"

        @query_str = @query_str+"AND is_attorney='1' "

        @check_attorney = "checked"

      else
        attorney = ""
      end

      if params[:notary_search][:title_producer] == "1"

        title_producer = "Yes"

        @query_str = @query_str+"AND title_insurance_provider='Yes' "

        @check_title_producer = "checked"
      else
        title_producer = ""
      end

      if params[:notary_search][:email_capable] == "1"

        email_capable = "Yes"

        @query_str = @query_str+"AND email_document_capability='Yes' "

        @check_email_capable = "checked"

      else
        email_capable = ""
      end

      if params[:notary_search][:reverse_mortgage] == "1"

        reverse_mortgage = "Yes"

        @query_str = @query_str+"AND reverse_mortgage='Yes' "

        @check_reverse_mortgage = "checked"
      else
        reverse_mortgage = ""
      end

      if params[:notary_search]["life_settlement_experience"] == "1"

        life_settlement = "Yes"

        @query_str = @query_str+"AND life_settlement_experience='Yes' "

        @check_life_settlement = "checked"

      else
        life_settlement = ""
      end
      if params[:notary_search]["enotarization_capability"] == "1"

        enotification = "Yes"

        @query_str = @query_str+"AND enotarization_capability='Yes' "

        @check_enotification = "checked"

      else
        enotification = ""
      end

      if params[:notary_search]["accepted_notary"] == "1"
        accepted_notary="Yes"
        @accepted_notary= "checked"
      else
        accepted_notary=""
      end

      @miles = params[:order]["search_radius"]

    end

    @multiple_notary=[]
    MultipleNotary.find_all_by_order_id(@order.id).each do |f|
      if f.accept_status==true
        @multiple_notary << f.notary_id
      end
    end

    if additional_language =="" and attorney == "" and title_producer == "" and email_capable == "" and reverse_mortgage == "" and  life_settlement == "" and enotification == ""
      if accepted_notary== "Yes" && !@multiple_notary.empty?
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true AND id IN (?)"),@multiple_notary],:order=>"distance asc" )
      else

        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true ",:order=>"distance asc" )

      end
    elsif additional_language == "Yes"
      if accepted_notary== "Yes" && !@multiple_notary.empty?
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true AND bilingual_language = '#{language}' #{@query_str} AND id IN (?)"),@multiple_notary],:order=>"distance asc" )
      else
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "(on_vacation IS NOT true AND bilingual_language = '#{language}' #{@query_str})",:order=>"distance asc" )
      end
    else
      if accepted_notary== "Yes" && !@multiple_notary.empty?
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true #{@query_str} AND id IN (?)"),@multiple_notary],:order=>"distance asc" )
      else
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "(on_vacation IS NOT true #{@query_str})",:order=>"distance asc" )
      end
    end
    @notaries_count = @notaries.count
    @notaries = @notaries.paginate :page => params[:page], :per_page => 15
  rescue
    redirect_to({:action => :open_order}.merge!(params))
  end

  def assign_notary
    @order = Order.find(params[:order_id])
    @notary = Notary.find(params[:notary_id])
    #~ notary_fee = @notary.fee
    #~ if @order.loan_type == "Email"
      #~ signing_fee = notary_fee.to_f + 175.0
    #~ elsif @order.loan_type == "Email 1&2"
      #~ signing_fee = notary_fee.to_f + 225.0
    #~ elsif @order.loan_type == "Overnight"
      #~ signing_fee = notary_fee.to_f + 175.0
    #~ elsif @order.loan_type == "Overnight 1&2"
      #~ signing_fee = notary_fee.to_f + 225.0
    #~ elsif @order.loan_type == "ESIGN"
      #~ signing_fee = notary_fee.to_f + 350.0
    #~ elsif @order.loan_type == "ESIGN 1&2"
      #~ signing_fee = notary_fee.to_f + 400.0
    #~ end
    signing_fee = @order.client.customer_fee
  
    notary_email = User.find(@notary.user_id)
    notary_email = notary_email.email
				status_log = @order.status_log.to_s + "#Notary Assigned: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} -#{session[:admin_user]} Admin"
    @order.update_attributes(:notary_id => params[:notary_id], :status => "filled", :status_timeline=> "Notary Assigned", :signing_fee => signing_fee, :customer_fee => signing_fee, :status_log => status_log)
    Notifier.deliver_notary_assign_order_confirmation(@order, @notary, notary_email)
    flash[:notice] = "Notary Assigned"
    redirect_to({:controller => '/admin/orders', :action => 'open_order', :tab => 'tabs3'})
  end

  def send_mail_to_notaries
    notary = Notary.find_by_id(params[:id])
    notary_email = User.find(notary.user_id)
    notary_email = notary_email.email
    @orderid = Order.find_by_id(params[:order_id])
    mul_notary = MultipleNotary.find_by_order_id(params[:order_id])
    mul_not = MultipleNotary.find_by_notary_id_and_order_id(params[:id],params[:order_id])

    if mul_notary.nil?
      order = MultipleNotary.new
      order.update_attributes(:notary_id => params[:id],:order_id => params[:order_id],:status => "not filled" )
    else
      if !mul_not.nil?
      else
        order = MultipleNotary.new
        order.update_attributes(:notary_id => params[:id],:order_id => params[:order_id],:status => "not filled" )
      end
    end
    Notifier.deliver_send_email_to_notary(@orderid,notary_email,params[:id],params[:mile])
    if mul_not.nil? or !mul_not.accept_status
      @mail_count = MultipleNotary.find_by_notary_id_and_order_id(params[:id],params[:order_id])
      @mail_count.update_attributes(:mail_count => @mail_count.mail_count+1)
      render :update do |page|
        page.replace_html "alert_count_#{notary.id}" , "Message Sent (#{@mail_count.mail_count})"
      end
    else
      render :update do |page|
        page.replace_html "alert_count_#{notary.id}" , 'Notary Accepted the Order.'
      end
    end
  end

  def order_detail
    @order = Order.find(params[:order_id])
    @order_feedback = OrderFeedback.find(:all, :conditions => ["order_id = ?", @order.id]).first

    # find whether the order detail page fetched from Attention tab ( tabs5 )
    if params[:tab] == 'tabs5'
												@notes=Notes.find_all_by_order_id(params[:order_id])
												# update all notes of the order require_attention to false
												@notes.each { |note|
																				note.update_attribute(:require_attention, false)
												}
				end
    @client = @order.client
    @notary = @order.notary
    @agent = @order.agent

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

  def delete_attachment
    id = params[:id]
    idsSplit = id.split(/_ */)
    attachmentFileId = idsSplit[0]
    orderId = idsSplit[1]
    @order = Order.find(orderId.to_i)
    attachment = "order_attachment_" + attachmentFileId.to_s
    @order.update_attribute(attachment, nil)
    if params[:redirect_to].present?
      redirect_to params[:redirect_to]
    else
      redirect_to :action => "edit", :id => orderId
    end
  end

  def update
    @order = Order.find(params[:id])
    @internal_notes = Notes.create(params[:internal].merge!({:order_id => params[:id]})) if params[:internal] && params[:internal][:notes].present?
    @customer_notes = Notes.create(params[:customer].merge!({:order_id => params[:id], :user_id => @order.client.user_id})) if params[:customer] && params[:customer][:notes].present?
    @notary_notes = Notes.create(params[:notary].merge!({:order_id => params[:id], :user_id => @order.notary.user_id})) if params[:notary] && [:notes].present? && @order.notary

    if params[:order]
      @order.update_attributes(params[:order])

      @order.attachment_1_file_name = params['fileName1']
      @order.attachment_1_file_url = params['fileUrl1']
      @order.attachment_2_file_name = params['fileName2']
      @order.attachment_2_file_url = params['fileUrl2']
      @order.attachment_3_file_name = params['fileName3']
      @order.attachment_3_file_url = params['fileUrl3']
      @order.attachment_4_file_name = params['fileName4']
      @order.attachment_4_file_url = params['fileUrl4']
      @order.attachment_5_file_name = params['fileName5']
      @order.attachment_5_file_url = params['fileUrl5']
      @order.attachment_6_file_name = params['fileName6']
      @order.attachment_6_file_url = params['fileUrl6']

      @order.save
      attachments = []
      if !@order.order_attachment_1_file_name.nil?
        attachments << @order.order_attachment_1_file_name
      end
      if !@order.order_attachment_2_file_name.nil?
        attachments << @order.order_attachment_2_file_name
      end
      if !@order.order_attachment_3_file_name.nil?
        attachments << @order.order_attachment_3_file_name
      end
      if !@order.order_attachment_4_file_name.nil?
        attachments << @order.order_attachment_4_file_name
      end
      if !@order.order_attachment_5_file_name.nil?
        attachments << @order.order_attachment_5_file_name
      end
      if !@order.order_attachment_6_file_name.nil?
        attachments << @order.order_attachment_6_file_name
      end

      @order.update_attributes(params[:order].merge!(:attachments_count => attachments.count + 1))

    end

    flash[:notice] = "Your order has been updated"
    redirect_to(request.referrer)
  end

  def create_feedback
    @order = Order.find(params[:order_feedback][:order_id])
				status_log = @order.status_log.to_s + "#Order Completed: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{session[:admin_user]} Admin"
    @order.update_attributes(:feedback => "completed", :status_timeline => "Feedback Complete", :status_log => status_log) #as per client requirement  status changed

    params[:order_feedback].merge!(:fees => params[:order_feedback_fees],
                                   :communication => params[:order_feedback_communication],
                                   :doc_issue => params[:order_feedback_doc_issue],
                                   :client_professionalism => params[:order_feedback_client_professionalism],
                                   :accuracy => params[:order_feedback_accuracy],
                                   :punctuality => params[:order_feedback_punctuality],
                                   :status_update => params[:order_feedback_status_update],
                                   :professionalism => params[:order_feedback_professionalism],
                                   :overall => params[:order_feedback_overall],
                                   :satisfaction => params[:order_feedback_satisfaction])
    params[:order_feedback].merge!(:client_id => @order.client_id, :notary_id => @order.notary_id)

    is_feedback = false
    @order_feedback = OrderFeedback.find_by_order_id(@order.id)
    if @order_feedback
      @total_feedbacks = params[:order_feedback][:fees].to_i +
          params[:order_feedback][:communication].to_i +
          params[:order_feedback][:doc_issue].to_i +
          params[:order_feedback][:client_professionalism].to_i +
          params[:order_feedback][:accuracy].to_i +
          params[:order_feedback][:punctuality].to_i +
          params[:order_feedback][:status_update].to_i +
          params[:order_feedback][:professionalism].to_i +
          params[:order_feedback][:overall].to_i +
          params[:order_feedback][:satisfaction].to_i

      @overall_rating = @total_feedbacks.to_f / 10
      params[:order_feedback].merge!(:overall_rating => @overall_rating)
      is_feedback = true if @order_feedback.update_attributes(params[:order_feedback])
    else
      @order_feedback = OrderFeedback.new(params[:order_feedback])
      is_feedback = true if @order_feedback.save
    end

    if is_feedback
      ##@order.update_attributes(:status =>"closed") #as per client requirement  status changed
      flash[:notice] = "Thank you for your feedback!"
      redirect_to(:controller => "admin/orders", :action => :order_detail, :order_id => @order.id, :tab => params[:tab])
    else
      render :action => :order_detail, :order_id => @order.id, :tab => params[:tab]
    end
  end

  def details
    @order = Order.find(params[:id])
    content = @order.admin_invoice(@order)
    send_data(content.to_pdf, :filename => "customer_invoice#{@order.id}.pdf", :disposition => 'inline', :type => 'application/pdf')
  end

  def edit
    @order = Order.find(params[:id])
    @notary = @order.notary
    @client = Client.find_by_user_id(@notary.user_id) if @notary
  end

  def complete_order
    @order = Order.find(params[:id])

    if params[:order][:return_account_number]
      client = Client.find_by_id(@order.client_id)
      # agent = Agent.find(@order.agent_id).email if !@order.agent_id.blank?
      agent = Agent.find(@order.agent_id) if !@order.agent_id.blank?
      client_email = User.find(client.user_id).email
				  status_log = @order.status_log.to_s + "#Signing Completed: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{session[:admin_user]} Admin"
      @order.update_attributes(:status_timeline => "Signing Completed",
                               :return_account_number => params[:order][:return_account_number],
                               :return_shipping_courier => params[:order][:return_shipping_courier],
                               :signing_comments => params[:order][:signing_comments],
                               :status_log => status_log
      )

      if @order.status_timeline=="Signing Completed"
        Notifier.deliver_mail_to_client_for_signing_completed(@order, client_email)
        Notifier.deliver_mail_to_agent_for_signing_completed(@order, agent) if !@order.agent_id.blank?
      end
    elsif params[:order][:closed_comments]
      @order.update_attributes(:status => "closed",
                               :closed_carrier => params[:order][:closed_carrier],
                               :closed_tracking_number => params[:order][:closed_tracking_number],
                               :closed_comments => params[:order][:closed_comments],
                               :feedback => "needed"
      )

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
      redirect_to(:action => "order_detail").merge!(params)
    end

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

      agent = Agent.find(@order.agent_id) if !@order.agent_id.blank?
      client_email = User.find(client.user_id).email


      if @order.status_timeline == "Time/Date Signing Set"
				    status_log = @order.status_log.to_s + "#Appt Confirmed: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{session[:admin_user]} Admin"
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

  def mark_completed
    @order = Order.find_by_id(params[:id])
    if @order.present?
      status_log = @order.status_log.to_s + "#Order Completed: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{session[:admin_user]} Admin"
      @order.update_attributes(:status_timeline => "Order Completed", :status_log => status_log)
    end
    render :js => "window.location = '#{request.referer}'"
  end
end
