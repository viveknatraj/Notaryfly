# include GeoKit::Mappable
require 'total_apps'
class Client::OrdersController < ApplicationController
  include SslRequirement
  include Admin::NotariesHelper
  include ActionView::Helpers::NumberHelper

  ssl_required :buy_credits
  before_filter :credits
  before_filter :require_login_client

  def index
    @client = Client.find_by_user_id(self.current_user.id)
   sort_by = {
        "Signer Name" => "borrower_1_last_name ASC",
        "Appointment Scheduled" => "signing_date ASC",
        "NF #" => "loan_number ASC",
        "Order Opened" => "created_at DESC",
    }
    per_page = 20
    @filter = sort_by[params[:filter]] rescue nil
    @filter ||= "created_at DESC"

    @orders = Order.find(:all, :conditions => ["client_id = ? AND admin_approve IS NULL AND cancel_order_date IS NULL and status != 'closed'", @client.id], :order => @filter).paginate :page => params[:page], :per_page => per_page
    @refuse_to_sign_orders  = Order.paginate :page => params[:page], :per_page => per_page, :conditions => ["cancel_order_date IS NOT NULL AND move_to_order_history_by_admin=false"], :order => "updated_at DESC"
				@completed_orders = Order.find(:all, :conditions => ["client_id = ? AND status_timeline = 'Order Completed'", @client.id], :order => @filter).paginate :page => params[:page], :per_page => per_page
  end


  def new
    @client = Client.find_by_user_id(self.current_user.id)
    #as per client request removed
    #@credits_cnt = Credit.find_by_user_id(self.current_user.id)

    #@remain_credits = @credits_cnt.credits

    @order = Order.new
  end

  def edit
    @client = Client.find_by_user_id(self.current_user.id)
    @order = Order.find(params[:id])
    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
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
    @order.update_attributes(:attachments_count => attachments.count + 1)

    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email
      Notifier.deliver_notary_order_edit(@order, notary_email) # notary_email
    end

    # redirect_to :action => "details", :id => params[:id]
    if params[:redirect_to].present?
      redirect_to params[:redirect_to]
    else
      redirect_to :action => "index"
    end

    flash[:notice] = "Your order has been updated"
  end

  def create
    if params["cancel.x"]
      redirect_to(:action => 'index')
    elsif params["later.x"]
      @order = Order.new(params[:order])
      if params[:order][:delivery_options]=='Commercial Loan'
        @signing_type="Commercial"

      elsif params[:order][:delivery_options]=="Email to Notary" || params[:order][:delivery_options]=="Email to Borrower"
        @signing_type="Email"
      else
        @signing_type="Overnight"
      end

      @order.status = "need notary"
      @client = Client.find_by_user_id(self.current_user.id)
      @order.client_id = @client.id

      # This is code to store special instruction file into particular orders

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

      # following is a code to update status log value
      @order.status_log = "Placed New Order: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{@client.client_name} Customer"
      # End

      if @order.save
        #as per client request added 1 credit for each order placed
        @credits = Credit.find_by_user_id(self.current_user.id)
        new_credits = @credits.credits + 1
        @credits.update_attributes(:credits => new_credits)
        redirect_to(:action => 'index')
      end
    else
      @order = Order.new(params[:order])
      @order.status = "need notary"
      @client = Client.find_by_user_id(self.current_user.id)
      @order.client_id = @client.id


      # This is code to store special instruction file into particular orders

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

      # following is a code to update status log value
      @order.status_log = "Placed New Order: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{@client.client_name} Customer"
      # End
      if @order.save
        @note = Notes.new(:notes => params[:notes].first, :order_id => @order.id, :user_id => self.current_user.id)
        @note.save

        #as per client request added 1 credit for each order placed
        @credits = Credit.find_by_user_id(self.current_user.id)
        new_credits = @credits.credits + 1
        @credits.update_attributes(:credits => new_credits)
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
        @order.update_attributes(:attachments_count => attachments.count)
        #redirect_to(:action => 'find_notary', :id => @order.id)
        redirect_to(:action => 'index')
      end
      # as per client need commented credits
      #      else
      #        redirect_to(:action => "new")
      #        flash[:notice] ="We're sorry, you have no credits remaining. Please purchase more credits."
      #      end
    end
  end

  def history
    @client = Client.find_by_user_id(self.current_user.id)
     sort_by = {
        "Signer Name" => "borrower_1_last_name ASC",
        "Appointment Scheduled" => "signing_date ASC",
        "NF #" => "loan_number ASC",
        "Order Opened" => "created_at DESC",
    }
    per_page = 20
    @filter = sort_by[params[:filter]] rescue nil
    @filter ||= "created_at DESC"

    @orders = Order.find(:all, :conditions => ["client_id = ? AND admin_approve = ?", @client.id, 1], :order => @filter).paginate :page => params[:page], :per_page => per_page
    @refused_to_sign_orders = Order.find(:all, :conditions => ["client_id = ? AND admin_approve IS NULL AND status != 'closed' AND (status = ? ) ", @client.id, "Refuse To Sign"], :order => @filter).paginate :page => params[:page], :per_page => per_page
    @paid_orders = Order.find(:all, :conditions => ["client_id = ? AND admin_approve IS NULL AND status != 'closed' AND (status_timeline = ? ) ", @client.id, "Notary Paid in Full" ], :order => @filter).paginate :page => params[:page], :per_page => per_page

  end

  def order_detail
    @order = Order.find(params[:order_id])
    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end

    if @order.client_id
      @client = @clientdd = Client.find(@order.client_id)
    end

    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
    end
  end

  def details
    @order = Order.find(params[:id])
    content = @order.customer_invoice(@order)
    send_data(content.to_pdf, :filename => "customer_invoice#{@order.id}.pdf", :disposition => 'inline', :type => 'application/pdf')
  end
    



  def resend_confirmation
    @order = Order.find(params[:id])
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

    Notifier.deliver_client_order_confirmation(@order, @agent, @notary, client_email) #client_email

    if @order.notary_id
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email
      Notifier.deliver_notary_order_confirmation(@order, @agent, @notary, notary_email) #notary_email
    end
    # redirect_to :action => 'details', :id => @order.id
    redirect_to :action => 'index'
    flash[:notice] ="Order email confirmation re-sent."

  end

  def feedback
    @order = Order.find(params[:id])
    @feedback = OrderFeedback.new
  end

  def create_feedback
    @client = Client.find_by_user_id(self.current_user.id)
    @order = Order.find(params[:order_feedback][:order_id])
    @order.update_attributes(:feedback => "completed", :status_timeline => "Feedback Complete") #as per client requirement  status changed
    @feedback = OrderFeedback.new(params[:order_feedback])
    @feedback.client_id = @client.id
    @feedback.notary_id = @order.notary_id
    @total_feedbacks = params[:order_feedback][:accuracy].to_i + params[:order_feedback][:communication].to_i + params[:order_feedback][:punctuality].to_i + params[:order_feedback][:professionalism].to_i + params[:order_feedback][:fees].to_i
    @overall_rating = @total_feedbacks.to_f / 5
    @feedback.overall_rating = @overall_rating
    if @feedback.save
      #@order.update_attributes(:status =>"closed") #as per client requirement  status changed
      redirect_to(:action => 'index')
      flash[:notice] = "Thank you for your feedback!"
    end
  end

  def find_notary
    @order = Order.find(params[:id])
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
      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true", :order => "distance asc")

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

    if additional_language =="" and attorney == "" and title_producer == "" and email_capable == "" and reverse_mortgage == "" and life_settlement == "" and enotification == ""

      if accepted_notary== "Yes" && @multiple_notary!=nil
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true AND id IN (?)"), @multiple_notary], :order => "distance asc")
      else

        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true ", :order => "distance asc")

      end
    elsif additional_language == "Yes"
      if accepted_notary== "Yes" && @multiple_notary!=nil
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true AND bilingual_language = '#{language}' #{@query_str} AND id IN (?)"), @multiple_notary], :order => "distance asc")
      else
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "(on_vacation IS NOT true AND bilingual_language = '#{language}' #{@query_str})", :order => "distance asc")
      end
    else
      if accepted_notary== "Yes" && @multiple_notary!=nil
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => [("on_vacation IS NOT true #{@query_str} AND id IN (?)"), @multiple_notary], :order => "distance asc")
      else
        @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "(on_vacation IS NOT true #{@query_str})", :order => "distance asc")
      end
    end


  end


  def send_mail_to_notaries
    notary = Notary.find_by_id(params[:id])
    notary_email = User.find(notary.user_id)
    notary_email = notary_email.email
    @orderid = Order.find_by_id(params[:order_id])
    mul_notary = MultipleNotary.find_by_order_id(params[:order_id])
    mul_not = MultipleNotary.find_by_notary_id_and_order_id(params[:id], params[:order_id])
    if mul_notary.nil?
      order = MultipleNotary.new
      order.update_attributes(:notary_id => params[:id], :order_id => params[:order_id], :status => "not filled")
    else
      if !mul_not.nil?
        if (mul_not.notary_id.to_i == params[:id].to_i and mul_not.order_id.to_i == params[:order_id].to_i)

        end
      else
        order = MultipleNotary.new
        order.update_attributes(:notary_id => params[:id], :order_id => params[:order_id], :status => "not filled")
      end
    end
    if mul_not.nil? or !mul_not.accept_status
      Notifier.deliver_send_email_to_notary(@orderid, notary_email, params[:id], params[:mile])
      @mail_count = MultipleNotary.find_by_notary_id_and_order_id(params[:id], params[:order_id])
      @mail_count.update_attributes(:mail_count => @mail_count.mail_count+1)
      render :update do |page|
        page.replace_html "not_#{params[:id]}", "Your Message Has Been Sent (#{@mail_count.mail_count})"
      end

    else
      render :update do |page|
        page.replace_html "notary_#{params[:id]}", 'Notary Accepted the Order '
      end
    end
  end

  def notary_search
    @order = Order.find(params[:id])
    @notaries = Notary.find(:all)
  end

  def confirm_notary

    @order = Order.find(params[:order_id])
    if @order.status != "filled" and @order.status != "closed"
      @order.update_attributes(params[:order])

      if params[:address]=="weekday"
        @order.update_attributes(:order_notary_contact_address => params[:weekday_order_notary_contact_address], :order_notary_contact_city => params[:weekday_order_notary_contact_city], :order_notary_contact_state => params[:weekday_order_notary_payment_state], :order_notary_contact_zip_code => params[:weekday_order_notary_contact_zip_code])
      elsif params[:address]=="weekend"
        @order.update_attributes(:order_notary_contact_address => params[:weekend_order_notary_contact_address], :order_notary_contact_city => params[:weekend_order_notary_contact_city], :order_notary_contact_state => params[:weekend_order_notary_payment_state], :order_notary_contact_zip_code => params[:weekend_order_notary_contact_zip_code])
      else
        @order.update_attributes(:order_notary_contact_address => params[:order_notary_payment_address], :order_notary_contact_city => params[:order_notary_payment_city], :order_notary_contact_state => params[:order_notary_payment_state], :order_notary_contact_zip_code => params[:order_notary_payment_zip_code])
      end

      # update status log for showing action history properly
      #status_log = @order.status_log.to_s + "#Notary Assigned: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{@order.client.client_name} Customer"
      @order.update_attributes(:notary_id => params[:id], :status => "filled", :status_timeline => "Notary Assigned", :doc_delivery_address_option => params[:address])

      #notary_fee_calculation & signing fee calculation
      current_fee= notary_fee(params[:id])[2]

      if @order.delivery_options=='Commercial Loan'
        @signing_type="Commercial"
      else
        if @order.delivery_options=="Email to Notary" || @order.delivery_options=="Email to Borrower"
          @signing_type="Email"
        else
          @signing_type="Overnight"
        end
      end

      if @signing_type=="Overnight"

        if @order.sets_of_docs==1
          @notary_fee=current_fee.to_f+25.0
          @signing_fee=100+@notary_fee
        else
          @notary_fee=current_fee.to_f+50.0
          @signing_fee=100+@notary_fee
        end
      elsif @signing_type=="Email"
        if @order.sets_of_docs==1
          @notary_fee=current_fee.to_f+50.0
          @signing_fee=100+@notary_fee
        else
          @notary_fee=current_fee.to_f+75.0
          @signing_fee=100+@notary_fee
        end
      else
        @notary_fee=0.00
        if @order.sets_of_docs==1
          @signing_fee=350.00
        else
          @signing_fee=400.00
        end
      end
      @order.signing_fee=number_with_precision(@signing_fee.to_f, :precision => 2)
      @order.notary_fee=number_with_precision(@notary_fee.to_f, :precision => 2)
      @order.save
      #calculation end

      @client = Client.find(@order.client_id)
      client_email = User.find(@client.user_id)
      client_email = client_email.email

      @notary = Notary.find(@order.notary_id)

      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email

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


      Notifier.deliver_client_order_confirmation(@order, @agent, @notary, client_email) #client_email


      Notifier.deliver_notary_order_confirmation(@order, @agent, @notary, notary_email) #notary_email
      accepted_notaries = @order.multiple_notaries
      all_notaries =[]
      accepted_notaries.each do |accepted_notary|
        all_notaries << Notary.find(accepted_notary.notary_id) if accepted_notary.notary_id
      end
      notary_emails = []
      all_notaries.each do |all_notary|
        user = User.find(all_notary.user_id) if all_notary.user_id
        notary_emails << user.email
      end

      subtract_email =[]
      subtract_email << notary_email
      notary_emails = notary_emails-subtract_email
      Notifier.deliver_notary_rejection_confirmation(@order, notary_emails) #Rejected notaries email

      flash[:notice] = "Your order has been placed and the assigned notary has been notified."
    else
      flash[:notice] = "Your order has already been placed and the assigned notary has been notified."
    end

    redirect_to :action => "index"

  end

  def complete_order
    @order = Order.find(params[:id])
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

    if @order.agent_id
      @agent = Agent.find_by_id(@order.agent_id)
      if @agent!=nil
        if @agent.notify_agent == "Yes"
          agent_email = @agent.email
          Notifier.deliver_agent_order_completed(@order, agent_email) #agent_email
        end
      end
    end

    Notifier.deliver_client_order_completed(@order, client_email) #client_email
    Notifier.deliver_client_feedback_mail(@order, @agent, @notary, client_email)
    # Notifier.deliver_notary_order_completed(@order,'venkateswaransk@dckap.com' ) notary_email

    flash[:notice] = "The order number #{@order.id} has been closed and can now be found under the history tab"
    redirect_to :action => "index"
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

    Notifier.deliver_client_order_confirmation(@order, @agent, @notary, client_email) #client_email

    if @order.notary_id
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email
      Notifier.deliver_notary_order_confirmation(@order, @agent, @notary, notary_email) #notary_email
    end

    redirect_to :action => 'index'
  end

  def send_confirmation_from_orders
    @order = Order.find(params[:id])

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

    Notifier.deliver_client_order_confirmation(@order, @agent, @notary, client_email) #client_email

    if @order.notary_id
      notary_email = User.find(@notary.user_id)
      notary_email = notary_email.email
      Notifier.deliver_notary_order_confirmation(@order, @agent, @notary, notary_email) #notary_email
    end
    redirect_to :action => 'index'
    flash[:notice] ="Order email confirmation re-sent."

  end

  def use_notary

    @notaries = Notary.find(:all, :conditions => ["id = ?", params[:id]]);

  end

  def add_notes
    @notes = Notes.new
    @notes.order_id = params[:id]
    @notes.user_id = self.current_user.id
    @notes.notes = params["notes"][:notes]
				# set require_attention to display the order in attention tab
				@notes.require_attention = true
    @notes.save
    redirect_to(:action => 'order_detail', :order_id => params[:id], :tab => params[:tab])
  end

  def add_notes_from_history
    @notes = Notes.new
    @notes.order_id = params[:id]
    @notes.user_id = self.current_user.id
    @notes.notes = params["notes"][:notes]
    @notes.save
    redirect_to(:action => 'history')
  end

  def cancel_order

    @order = Order.find_by_id(params[:orderid])
    @order.update_attribute(:cancel_order, params[:cancel_order])
    @order.update_attribute(:cancel_order_date, Date.today)

    @order.save
    if !@order.cancel_order.blank?
      client = Client.find_by_id(@order.client_id)
      notary = Notary.find_by_id(@order.notary_id)
      agent = Agent.find(@order.agent_id).email if !@order.agent_id.blank?
      notary_email = User.find(notary.user_id).email if !notary.blank?
      client_email = User.find(client.user_id).email if !client.blank?

      Notifier.deliver_cancel_order_for_client(@order, client_email)
      Notifier.deliver_cancel_order_for_notary(@order, notary_email)
      Notifier.deliver_cancel_order_for_agent(@order, agent) if !@order.agent_id.blank?
      Notifier.deliver_cancel_order_for_admin(@order)
    end
    redirect_to(request.referrer)
  end

  def send_mail_for_documents_received
    @order = Order.find_by_id(params[:id])
    # update status log for showing action history properly
				updated_by = @order.agent_id.present? ? @order.agent.broker_name : @order.notary.first_name
    #status_log = @order.status_log.to_s + "#Appt Confirmed: #{Time.now.strftime('%m/%d/%y - %I:%M %p')} - #{updated_by} Customer"
    @order.update_attributes(:status_timeline => "Documents Received by Title/Escrow")

    if @order
      agent = Agent.find(@order.agent_id).email if !@order.agent_id.blank?
      Notifier.deliver_mail_to_agent_for_documents_received_title(@order, agent) if !@order.agent_id.blank?
      if @order.notary_id
        notary = Notary.find(@order.notary_id)
        notary_email= User.find(notary.user_id).email
        Notifier.deliver_mail_to_notary_for_documents_received_title(@order, notary_email)
      end
    end
    render :js => "window.location = '#{request.referer}'"
  end

  def send_mail_for_loan_fund

    @order = Order.find_by_id(params[:id])
    @notary = Notary.find(@order.notary_id)
    fee=notary_fee(@notary.id)

    #Mailing functionalities
    if @order.status_timeline=="Documents Received by Title/Escrow"
      @order.update_attributes(:status_timeline => "Loan Funded")
    elsif @order.status_timeline=="Loan Funded"
      @order.update_attributes(:status_timeline => "Feedback Complete")
    elsif @order.status_timeline=="Feedback Complete"
      @order.update_attributes(:status_timeline => "Notary Paid in Full")
    end
    if @order
      agent = Agent.find(@order.agent_id) if !@order.agent_id.blank?
      client = Client.find_by_id(@order.client_id)
      client_email = User.find(client.user_id).email
      if @order.status_timeline == "Loan Funded"
        if @order.notary_id
          notary_email= User.find(@notary.user_id).email
          Notifier.deliver_mail_to_notary_for_loan_fund(@order, notary_email)
        end
        Notifier.deliver_mail_to_client_for_loan_fund(@order, client_email)
        Notifier.deliver_mail_to_agent_for_loan_fund(@order, agent) if !@order.agent_id.blank?

      elsif @order.status_timeline == "Notary Paid in Full"
        #as per client request added 1 credit for each order placed
        @credits = Credit.find_by_user_id(self.current_user.id)
        new_credits = @credits.credits - 1
        @credits.update_attributes(:credits => new_credits)
        if @order.notary_id
          notary_email= User.find(@notary.user_id).email
          Notifier.deliver_mail_to_notary_for_paid_full(@order, notary_email, fee)
        end
        Notifier.deliver_mail_to_client_for_paid_full(@order, client_email)
        #Notifier.deliver_mail_to_agent_for_paid_full(@order,agent) if !@order.agent_id.blank?
      end
      render :nothing => true
    end


  end


  def download
    @paths = params[:path].split("\?")
    @path=RAILS_ROOT+"/public"+@paths[0]
    send_file("#{@path}", :type => 'all')
  end

  # Payment Module #

  def payment
    @order = Order.find(params[:id])
  end


  def do_payment
    order_id = params[:id]
    order = Order.find(order_id)
    gw = GwApi.new()
    year = params[:date][:year]
    expiry_year = year[2..3]
    month = params[:date][:month]
    if month.length == 2
      expiry_month = month
    elsif month.length == 1
      expiry_month = "0"+month
    end
    expiry_month_year = expiry_month + expiry_year
    card_number = params[:card_number]
    cvv = params[:card_code]
    #gw.setLogin("totalappsgatewaydemo456", "jaron12345");
    gw.setLogin(PaymentLoginName, PaymentLoginPassword);
    gw.setBilling("John", "Smith", "Acme, Inc.", "123 Main St", "Suite 200", "Beverly Hills", "CA", "90210", "US", "555-555-5555", "555-555-5556", "support@example.com", "www.example.com")
    gw.setShipping("Mary", "Smith", "na", "124 Shipping Main St", "Suite Ship", "Beverly Hills", "CA", "90210", "US", "support@example.com")
    gw.setOrder("1234", "Big Order", 1, 2, "PO1234", "65.192.14.10")
    r = gw.doSale(order.signing_fee, card_number, expiry_month_year, cvv)
    myResponses = gw.getResponses
    if (myResponses['response'] == '1')
      print "Approved \n"
      flash[:notice] = "Order number #{order_id} payment was successfull"
      # updating client order payment details
      order.client_payment_date=Time.now
      order.save
      redirect_to :action => "index"
    elsif (myResponses['response'] == '2')
      print "Declined \n"
      flash[:errors] = "Order number #{order_id} payment Declined. <br/>Error: #{myResponses['responsetext']}"
      redirect_to :back
    elsif (myResponses['response'] == '3')
      print "Error \n"
      flash[:errors] = "Order number #{order_id} payment.<br/> Error: #{myResponses['responsetext']}"
      redirect_to :back
    end
  end


#def find_notary
#    @order = Order.find(params[:id])
#    @miles = 10
#    @dropdown_language = "display:none;"
#    @check_additional_language = ""
#    @check_attorney = ""
#    @check_title_producer = ""
#    @check_email_capable = ""
#    @check_reverse_mortgage = ""
#    @check_life_settlement = ""
#    @check_enotification = ""
#    @selected_lang = ""
#  #  Notary.distance_between(from, to)
#    unless params[:notary_search]
#      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true",:order=>"distance asc" )
#
#    else
#      if params[:notary_search][:additional_language] == "1"
#        additional_language = "Yes"
#        language = params[:order]['required_language']
#        @selected_lang = language
#        @check_additional_language = "checked"
#        @dropdown_language = "display:inline;"
#      else
#        additional_language = "No"
#      end
#
#      if params[:notary_search][:attorney] == "1"
#        attorney = 1
#        @check_attorney = "checked"
#      else
#        attorney = 0
#      end
#
#      if params[:notary_search][:title_producer] == "1"
#        title_producer = "Yes"
#        @check_title_producer = "checked"
#      else
#        title_producer = "No"
#      end
#
#      if params[:notary_search][:email_capable] == "1"
#        email_capable = "Yes"
#        @check_email_capable = "checked"
#      else
#        email_capable = "No"
#      end
#
#      if params[:notary_search][:reverse_mortgage] == "1"
#        reverse_mortgage = "Yes"
#        @check_reverse_mortgage = "checked"
#      else
#        reverse_mortgage = "No"
#      end
#
#      if params[:notary_search]["life_settlement_experience"] == "1"
#        life_settlement = "Yes"
#        @check_life_settlement = "checked"
#      else
#        life_settlement = "No"
#      end
#      if params[:notary_search]["enotarization_capability"] == "1"
#        enotification = "Yes"
#        @check_enotification = "checked"
#      else
#        enotification = "No"
#      end
#
#      @miles = params[:order]["search_radius"]
#
#    if additional_language =="No" and attorney == 0 and title_producer == "No" and email_capable == "No" and reverse_mortgage == "No" and  life_settlement == "No" and enotification == "No"
#      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true ",:order=>"distance asc" )
#    else if additional_language == "Yes"
#      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true AND bilingual = '#{additional_language}' AND bilingual_language = '#{language}' AND is_attorney = #{attorney} AND title_insurance_provider = '#{title_producer}' AND email_document_capability = '#{email_capable}' AND reverse_mortgage = '#{reverse_mortgage}' AND life_settlement_experience = '#{life_settlement}' AND enotarization_capability = '#{enotification}'",:order=>"distance asc" )
#    else
#      @notaries = Notary.find(:all, :origin => @order.signing_location_zip_code, :within => @miles, :conditions => "on_vacation IS NOT true AND bilingual = '#{additional_language}' AND is_attorney = #{attorney} AND title_insurance_provider = '#{title_producer}' AND email_document_capability = '#{email_capable}' AND reverse_mortgage = '#{reverse_mortgage}' AND life_settlement_experience = '#{life_settlement}' AND enotarization_capability = '#{enotification}'",:order=>"distance asc" )
#    end
#    end
#
#    end
#
#  end

end
