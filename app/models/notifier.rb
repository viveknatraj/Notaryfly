class Notifier < ActionMailer::Base
include ActionView::Helpers::TextHelper
include ActionView::Helpers::NumberHelper

  def client_signup(user,pwd)
    @recipients = user.email
	from  "noreply@notaryfly.com"
    @subject = "Welcome to NotaryFly "
    content_type "text/html"     #    <== note this line
    # Email body substitutions go here
    @body = {:user=>user,:pwd=>pwd}
  end

  def notary_signup(user,pwd)
    @recipients = user.email
    from "noreply@notaryfly.com"
    @subject = "Welcome to NotaryFly"
    content_type "text/html"     #    <== note this line
    # Email body substitutions go here
    @body = {:user=>user}
  end

  def mail_to_client_for_date_confirmed(order,client_mail)
    @order = order
    @notary = notary = @order.notary
    @recipients = client_mail
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  The TIME/DATE of this Signing has been CONFIRMED"
    @subject = "(#{@order.borrower_1_last_name.capitalize})NF ##{order.id} ESC# #{order.loan_number}: Date/Time CONFIRMED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order, :notary => notary}
  end

  def mail_to_agent_for_date_confirmed(order,agent)
    @order = order
    @agent = agent

    @recipients = agent.email
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  The TIME/DATE of this Signing has been CONFIRMED"
    #@subject = "NF Order# #{order.id}(#{@order.borrower_1_last_name.capitalize}):  Date/Time CONFIRMED"
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}): APPT CONFIRMED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order, :agent => agent}
  end

  def mail_to_client_for_documents_received_notary(order,client_mail)
    @recipients = client_mail
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}:  Documents RECEIVED by Notary "
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_agent_for_documents_received_notary(order,agent)
    @recipients = agent.email
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}:  Documents RECEIVED by Notary"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_client_for_signing_completed(order,client_mail)
    @recipients = client_mail
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}:  The Signing has been COMPLETED for this Order "
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_agent_for_signing_completed(order,agent)
    @order = order
    @agent = agent

    @recipients = agent.email
    from "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  The Signing has been COMPLETED for this Order "
    @subject = "NF Order# #{order.id}(#{@order.borrower_1_last_name.capitalize}): Signing COMPLETED"
    content_type 'text/html' #    <== note this line
    # Email body substitutions go here
    @body = {:order => order, :agent => agent}
  end

  def mail_to_client_for_loan_fund(order,client_name)
    @recipients = client_name
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}: Your Loan has FUNDED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_agent_for_loan_fund(order,agent)
    @order = order
    @agent = agent

    @recipients = agent.email
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}: Your Loan has FUNDED"
    @subject = "NF Order# #{order.id}(#{@order.borrower_1_last_name.capitalize}): Your Loan has FUNDED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_notary_for_loan_fund(order,notary)
    @recipients = notary
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}: Your Loan has FUNDED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
 end

  def mail_to_agent_for_documents_received_title(order,agent)
    @recipients = agent.email
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}: Loan Documents RECEIVED by Title/Escrow Dept"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

def mail_to_notary_for_documents_received_title(order,notary)
    @recipients = notary
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}: Loan Documents RECEIVED by Title/Escrow Dept"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_client_for_paid_full(order,client_name)
    @recipients = client_name
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}:  Your NF Order has been COMPLETED "
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def mail_to_notary_for_paid_full(order,notary,fee)
    @order = order
    @my_fee=fee
    @recipients = notary
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  You have been PAID in FULL on this Order "
    @subject = "NF Order ##{order.id}(#{@order.borrower_1_last_name.capitalize}):  Order PAID"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}

  end

  def send_email_to_notary(order,client_mail,notary,mile)
    @notary = notary = Notary.find_by_id(notary)
    #puts "========#{notary.inspect}"
    @recipients = client_mail
    from  "noreply@notaryfly.com"
 
    #@subject = "You Have Received an Order on NotaryFly"
    @subject = "NF Order ##{order.id}: Signing OFFERED.  Reply ASAP!"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order,:notary=> notary,:mile => mile}
  end

  def cancel_order_for_client(order,client_email)
    @recipients = client_email
    @notary = order.notary
    from  "noreply@notaryfly.com"
    #@subject = "You have received a message about a Notary Fly order"
    @subject = "(#{order.borrower_1_last_name.capitalize})NF ##{order.id} ESC# #{order.loan_number}: Order CANCELLED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

  def cancel_order_for_admin(order)
    @recipients = "admin@gmail.com"
    from  "noreply@notaryfly.com"
    @subject = "You have received a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

   def cancel_order_for_notary(order,notary_email)
    @recipients = notary_email
    from  "noreply@notaryfly.com"
    @subject = "NF Order ##{order.id} (#{order.borrower_1_last_name.capitalize}):  Order CANCELLED"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

  def cancel_order_for_agent(order,agent_email)
    @recipients = agent_email
    from  "noreply@notaryfly.com"
    @subject = "You have received a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

  def approve_cancel_with_travel_fee(order,client_email)
  @recipients= client_email
  from  "noreply@notaryfly.com"
  #@subject = "You have received a message about a Notary Fly order"
  @subject = "(#{order.borrower_1_last_name.capitalize})NF ##{order.id} ESC# #{order.loan_number}: Order CANCELLED - Approved with penalty"
    content_type 'multipart/mixed'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
    #Create file
    filename = create_pdf_file(order,order.agent,@notary)
  
    part :content_type => "text/html", :body => 
    render_message('approve_cancel_with_travel_fee', :order => order)
    
    attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
        :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf") 
  end

  def approve_cancel_without_travel_fee(order,client_email)
  @recipients= client_email
  @notary = order.notary
  from  "noreply@notaryfly.com"
  #@subject = "You have received a message about a Notary Fly order"
  @subject = "(#{order.borrower_1_last_name.capitalize})NF ##{order.id} ESC# #{order.loan_number}: Order CANCELLED - Approved"
    content_type 'multipart/mixed'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
    #Create file
    filename = create_pdf_file(order,order.agent,@notary)
  
    part :content_type => "text/html", :body => 
    render_message('approve_cancel_with_travel_fee', :order => order)
    
    attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
        :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf") 
  end

  def deny_cancel(order,client_email)
    @recipients= client_email
  from  "noreply@notaryfly.com"
  @subject = "You have received a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

  def notary_new_message_recipient(order,client_mail)

 # Email header info MUST be added here
    
    @recipients = client_mail
    from  "noreply@notaryfly.com"
    @subject = "You have received a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end

   def client_new_message_recipient(order,client_mail)

 # Email header info MUST be added here

    @recipients = client_mail
    from  "noreply@notaryfly.com"
    @subject = "You have received a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end
  
  def client_order_completed(order, client_email)

    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "Your NotaryFly order has been COMPLETED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end

  def notary_order_completed(order, notary_email)

    # Email header info MUST be added here
    if order.broker_id
      agent = Agent.find(order.broker_id)
    end
    
    if agent
      @recipients = notary_email, agent.email
    else
      @recipients = notary_email
    end
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "NF Order# #{order.id}(#{order.borrower_2_last_name.capitalize}):  Order COMPLETED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end

  def notary_paid(orders, notary_email)

    order = orders.first
    # Email header info MUST be added here
    if order.broker_id
      agent = Agent.find(order.broker_id)
    end
    
    if agent
      @recipients = notary_email, agent.email
    else
      @recipients = notary_email
    end
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "Notaryfly - Order(s) PAID"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:orders => orders}
  end

  def agent_order_completed(order, client_email)

    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "Your NotaryFly order has been COMPLETED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end

  def client_order_confirmation(order,agent,notary, client_email)
    @order = order
    @agent = agent
    @notary = notary

    @recipients = client_email
  
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  A Notary has been ASSIGNED to this Order"
    @subject = " (#{@order.borrower_1_last_name.capitalize})NF ##{order.id} ESC# #{order.loan_number}: Notary ASSIGNED"
    content_type 'multipart/mixed'   #    <== note this line
    
    # Email body substitutions go here
    @body = {:order => order, :agent => agent}
    
    #Create file
    filename = create_pdf_file(order,agent,notary)
  
    part :content_type => "text/html", :body => 
    render_message('client_order_confirmation', :order => order)
    
    attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
        :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf") 
    
  end
  
  
  def notary_rejection_confirmation(order,notary_emails)
    p "notary_rejection_confirmation #{notary_emails}  "
    order_id  = order.id
    #@recipients = notary_emails
    @bcc= notary_emails
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly Order ##{order.id}"
    content_type 'multipart/mixed' 
    
    part :content_type => "text/html", :body => "Dear Notary,
<p>##{order.id} was assigned to another notary<p>
<p>Thank You<p>
<a href='http://www.notaryfly.com'>NotaryFly.com</a>" 
  end
  


  def client_feedback_mail(order,agent,notary, client_email)

    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly - Please leave feedback"
    content_type 'multipart/mixed'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}

    #Create file
    filename = create_pdf_file(order,agent,notary)

    part :content_type => "text/html", :body =>
    render_message('client_feedback_mail', :order => order)

    attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
        :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf")

  end


  def client_feedback_remainder_mail(order,agent,notary, client_email)

    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly - Please leave feedback"
    content_type 'multipart/mixed'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}

    #Create file
    filename = create_pdf_file(order,agent,notary)

    part :content_type => "text/html", :body =>
    render_message('client_feedback_remainder_mail', :order => order)


  end


  def agent_order_confirmation(order, agent, notary, client_email)
    @order = order
    @agent = agent

    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  A Notary has been ASSIGNED to this Order"
    @subject = "NF Order# #{order.id}(#{@order.borrower_1_last_name.capitalize}):  Notary ASSIGNED"
    content_type 'multipart/mixed' #    <== note this line

    # Email body substitutions go here
    @body = {:order => order, :agent => agent}

    #Create file
    filename = create_pdf_file_for_agent(order, agent, notary)

    part :content_type => "text/html", :body =>
        render_message('client_order_confirmation', :order => order)

    attachment :content_type => "application/pdf", :filename => "NFWorkOrder.pdf",
               :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf")

  end

  def create_pdf_file(order,agent,notary)
  pdf = Prawn::Document.new

   #Styling
  eval(get_pdf_markup(order,agent,notary))

   #Create file
   filename = "invoice-#{order.id}.pdf"
   pdf.render_file "tmp/#{filename}"
  end

def create_pdf_file_for_agent(order,agent,notary)
    pdf = Prawn::Document.new

   #Styling
   eval(get_pdf_markup_for_agent(order,agent,notary))

   #Create file
   filename = "invoice-#{order.id}.pdf"
   pdf.render_file "tmp/#{filename}"
  end

  def create_pdf_complete_order(order,agent,notary)
    pdf = Prawn::Document.new

   #Styling
   eval(get_pdf_complete_order(order,agent,notary))

   #Create file
   filename = "invoice-#{order.id}.pdf"
   pdf.render_file "tmp/#{filename}"
  end
  
  def notary_order_confirmation(order,agent,notary,notary_email)
    @order = order
    @notary = notary
    @user = User.find(@notary.user_id)

    if order.broker_id
      agent = Agent.find(order.broker_id)
    end

    if agent
      @recipients = notary_email
    else
      @recipients = notary_email
    end
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    #@subject = "NotaryFly Order ##{order.id}:  This Order has been ASSIGNED to You"
    @subject = "NF Order ##{order.id}(#{@order.borrower_1_last_name.capitalize}): Order ASSIGNED"
    content_type 'multipart/mixed'   #    <== note this line

     # Email body substitutions go here
     @body = {:order => order}

     #Create file
     filename = create_pdf_file_for_notary(order,agent,notary)

     part :content_type => "text/html", :body => 
     render_message('notary_order_confirmation', :order => order)

     attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
         :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf")
      
     if !order.special_instructions.blank?
        sp_filename = create_pdf_file_for_spinstruction(order)
         attachment :content_type => "application/pdf", :filename=> "special_instructions.pdf",
         :body => File.read(RAILS_ROOT + "/tmp/specialinstructions-#{order.id}.pdf")
     end
     #Attachment 2#
     if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpeg"
         attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpg"
         attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/png"
         attachment :content_type => "image/png",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/pjpeg"
         attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/x-png"
         attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/msword"
         attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/octet-stream"
         attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_1_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/pdf"
         attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/word"
         attachment :content_type => "application/word",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
      end
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
       end
       
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.oasis.opendocument.text"
         attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
       end
       
      if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.ms-powerpoint"
         attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_2_file_name}",
         :body => File.read(order.order_attachment_2.path)
       end
      #Attachment 3 #
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpeg"
         attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpg"
         attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/png"
         attachment :content_type => "image/png",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/pjpeg"
         attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/x-png"
         attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/msword"
         attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/octet-stream"
         attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/pdf"
         attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/word"
         attachment :content_type => "application/word",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
       
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.oasis.opendocument.text"
         attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
       
      if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.ms-powerpoint"
         attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_3_file_name}",
         :body => File.read(order.order_attachment_3.path)
      end
       #Attachment 4 #
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpeg"
         attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpg"
         attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/png"
         attachment :content_type => "image/png",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/pjpeg"
         attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/x-png"
         attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/msword"
         attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/octet-stream"
         attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/pdf"
         attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/word"
         attachment :content_type => "application/word",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
       
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.oasis.opendocument.text"
         attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
       
      if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.ms-powerpoint"
         attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_4_file_name}",
         :body => File.read(order.order_attachment_4.path)
      end
       
      #Attachment 5 #
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpeg"
         attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpg"
         attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/png"
         attachment :content_type => "image/png",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/pjpeg"
         attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/x-png"
         attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/msword"
         attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/octet-stream"
         attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/pdf"
         attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/word"
         attachment :content_type => "application/word",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.oasis.opendocument.text"
         attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
       
      if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.ms-powerpoint"
         attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_5_file_name}",
         :body => File.read(order.order_attachment_5.path)
      end
       
       #Attachment 6 #
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpeg"
         attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpg"
         attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/png"
         attachment :content_type => "image/png",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/pjpeg"
         attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/x-png"
         attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/msword"
         attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/octet-stream"
         attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/pdf"
         attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/word"
         attachment :content_type => "application/word",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
         attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.oasis.opendocument.text"
         attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
       
       if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.ms-powerpoint"
         attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_6_file_name}",
         :body => File.read(order.order_attachment_6.path)
       end
   
  end

def notary_assign_order_confirmation(order, notary, notary_email)

  @notary = notary
  @recipients = notary_email
  from  "noreply@notaryfly.com"
  @subject = "NF Order ##{order.id}(#{order.borrower_1_last_name.capitalize}):  Order ASSIGNED"
  content_type 'multipart/mixed'   #    <== note this line

  # Email body substitutions go here
   @body = {:order => order}

  #Create file
  filename = create_pdf_file_for_notary(order,order.agent,notary)
  #
  part :content_type => "text/html", :body =>
      render_message('notary_assign_order_confirmation', :order => order)

  attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
             :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf")
  
  if !order.special_instructions.blank?
    sp_filename = create_pdf_file_for_spinstruction(order)
    attachment :content_type => "application/pdf", :filename=> "special_instructions.pdf",
               :body => File.read(RAILS_ROOT + "/tmp/specialinstructions-#{order.id}.pdf")
  end
  #Attachment 2#
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_1_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  #Attachment 3 #
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  #Attachment 4 #
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  #Attachment 5 #
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  
  #Attachment 6 #
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end

end

  def create_pdf_file_for_notary(order,agent,notary)
    pdf = Prawn::Document.new

   #Styling
   eval(get_pdf_markup_for_notary(order,agent,notary))

   #Create file
   filename = "invoice-#{order.id}.pdf"
   pdf.render_file "tmp/#{filename}"
 end
 
 
   def create_pdf_file_for_spinstruction(order)
    pdf = Prawn::Document.new
    pdf.text "Special Instructions:", :size => 15, :style => :bold
    pdf.text "#{order.special_instructions}"


   #Create file
   filename = "specialinstructions-#{order.id}.pdf"
   pdf.render_file "tmp/#{filename}"
 end
 

  
  def client_email_copy(message, client_email)
    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "A copy of your NotaryFly Message"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:message => message}
  end
  
  def notary_email_copy(order, notary_email)
    # Email header info MUST be added here
    if order.broker_id
      agent = Agent.find(order.broker_id)
    end
    
    if agent
      @recipients = notary_email, agent.email
    else
      @recipients = notary_email
    end
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "A NotaryFly order has been assigned to you"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end
  
  def notary_order_edit(order, notary_email)
    # Email header info MUST be added here
    if order.broker_id
      agent = Agent.find(order.broker_id)
    end
    
    if agent
      @recipients = notary_email, agent, order.cc_email
    else
      @recipients = notary_email, order.cc_email
    end
      
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "A NotaryFly order of yours has been edited"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:order => order}
  end
  
  def new_message_recipient(message, client_email)
    # Email header info MUST be added here
    @notary = User.find(message.recipient_id)
    @recipients = @notary.email
    from  "noreply@notaryfly.com"
    @subject = "You have been sent a message about a Notary Fly order"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:message => message}
  end
  
  def get_pdf_markup(order,agent,notary)
    if agent!=nil
      agent_company_name  = agent.company_name
      agent_broker_name   = agent.broker_name
      agent_address       = agent.address
      agent_city          = agent.city
      agent_state         = agent.state
      agent_zip_code      = agent.zip_code
      agent_home_phone    = agent.home_phone
      
      if !agent_home_phone.present?
        agent_home_phone = "Not Provided"
      end
      agent_home_extension = agent.home_extension

      if !agent_home_extension.present?
        agent_home_extension = "Not Provided"
      end
      agent_mobile_phone  = agent.mobile_phone

      if !agent_mobile_phone.present?
        agent_mobile_phone = "Not Provided"
      end
    end

    if notary!=nil

      notary_address = ""
      notary_city    = ""
      notary_state   = ""
      notary_zipcode = ""

      notary_first_name = order.notary.first_name
      notary_last_name  = order.notary.last_name
      notary_id   = order.notary.id
      notary_day_phone = order.notary.day_phone

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekday"
      notary_address = order.notary.weekday_deliver_address
      notary_city     = order.notary.weekday_deliver_city
      notary_state     = order.notary.weekday_deliver_state
      notary_zipcode  = order.notary.weekday_deliver_zip_code
      end
      
      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekend"
      notary_address = order.notary.weekend_deliver_address
      notary_city     = order.notary.weekend_deliver_city
      notary_state     = order.notary.weekend_deliver_state
      notary_zipcode  = order.notary.weekend_deliver_zip_code
      end

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="payment"
      notary_address  = order.notary.billing_deliver_address
      notary_city     = order.notary.billing_deliver_city
      notary_state     = order.notary.billing_deliver_state
      notary_zipcode  = order.notary.billing_deliver_zip_code
      end



      if !notary_day_phone.present?
        notary_day_phone = "Not Provided"
      end

      notary_evening_phone  = order.notary.evening_phone

       if !notary_evening_phone.present?
        notary_evening_phone = "Not Provided"
      end

      notary_mobile_phone = order.notary.mobile_phone

      if !notary_mobile_phone.present?
        notary_mobile_phone = "Not Provided"
      end

      notary_work_phone = order.notary.work_phone

      if !notary_work_phone.present?
        notary_work_phone = "Not Provided"
      end
      notary_user_email = order.notary.user.email

     notary_billing_payable_to = order.notary.billing_payable_to
     notary_billing_deliver_address = order.notary.billing_deliver_address
     notary_billing_deliver_city  = order.notary.billing_deliver_city
     notary_billing_deliver_state = order.notary.billing_deliver_state
     notary_billing_deliver_zip_code = order.notary.billing_deliver_zip_code
    end

    return <<-EOS

    pdf.stroke_rectangle [0,635], 250, 300
pdf.stroke_rectangle [300,635], 250, 300


pdf.stroke_rectangle [0,315], 250, 100
pdf.stroke_rectangle [300,315], 250, 100

pdf.stroke_rectangle [0,190], 550,137

pdf.text "NotaryFLY.com", :at => [0,700], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,700], :size => 17, :style => :bold
pdf.move_down(30)
#pdf.text "Please visit http://www.notaryfly.com and login with your username and", :at => [5,665], :size => 8
#pdf.text "password so you can provide up to date status on the signing.", :at => [5,655], :size => 8

#pdf.move_down(15)

pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "       NF Order # ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text "  : #{order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow # "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text "  : #{order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text "  : #{order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text "  : #{order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{order.client.address}" , :size => 8, :at =>[80,576]
pdf.text "    #{order.client.city} , #{order.client.state} #{order.client.zip_code}" , :size => 8, :at =>[80,568]
pdf.text "  Contact Name  " , :size => 9, :style => :bold, :at =>[10,556]

if order.client.client_name.size!=0
pdf.text "    : #{order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #  ", :size => 9, :style => :bold, :at =>[10,544]

if order.client.home_phone.size!=0
pdf.text "    : #{order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext # ", :size => 9, :style => :bold, :at =>[150,544]

if order.client.home_extension.size!=0
pdf.text "    : #{order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #  " , :size => 9, :style => :bold, :at =>[10,532]

if order.client.direct_phone.size!=0
pdf.text "    : #{order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #  " , :size => 9, :style => :bold, :at =>[10,520]

if order.client.mobile_phone.size!=0
pdf.text "    : #{order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,520]
end


if notary!=nil
pdf.text "               Notary  " , :size => 9, :style => :bold, :at =>[10,508]
pdf.text "    : #{notary_first_name} #{notary_last_name}" , :size => 8, :at =>[75,508]
pdf.text "    Doc Delivery" , :size => 9, :style => :bold, :at =>[10,496]
pdf.text "    : #{notary_address}" , :size => 8, :at =>[75,496]
pdf.text "           Address " , :size => 9, :style => :bold, :at =>[10,484]
pdf.text "    : #{notary_city}, #{notary_state} #{notary_zipcode}" , :size => 8, :at =>[75,484]
pdf.text "  NotaryFly ID #  " , :size => 9, :style => :bold, :at =>[10,472]
pdf.text "    : #{notary_id}" , :size => 8, :at =>[75,472]
pdf.text "      Signing Fee  " , :size => 9, :style => :bold, :at =>[10,460]

if !order.signing_fee.blank?
pdf.text "    : $#{number_with_precision(order.signing_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,460]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,460]
end

pdf.text "      Other Fee  " , :size => 9, :style => :bold, :at =>[10,448]

if order.travel_fee!=nil
pdf.text "    : $#{number_with_precision(order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,448]
else
pdf.text "    : Not Provided" , :size => 8, :at =>[75,448]
end

pdf.text "      Explanation   :  " , :size => 9, :style => :bold, :at =>[10,436]
i=436
if order.other_fee_reason!=nil
word_wrap(order.other_fee_reason,35).split("\n").each() do |explanation|
  if i>=424
    j="  "
pdf.text        j+explanation, :size => 9, :at => [83,i]
i=i-12
end
end
else
pdf.text "   : Not Provided" , :size => 8, :at =>[75,436]
end

pdf.text " Total Signing Fee  " , :size => 9, :style => :bold, :at =>[8,412]

if !order.signing_fee.blank? && order.travel_fee!=nil
 pdf.text "   : $#{number_with_precision((order.signing_fee.to_f + order.travel_fee.to_f),:precision=>2)}" , :size => 8, :at =>[75,412]
elsif !order.signing_fee.blank? && order.travel_fee==nil
pdf.text "   : $#{number_with_precision(order.signing_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,412]
elsif order.signing_fee.blank? && order.travel_fee!=nil
pdf.text "   : $#{number_with_precision(order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,412]
else
pdf.text "   : $0.00" , :size => 8, :at =>[75,412]
end


pdf.text "                 Day #  " , :size => 9, :style => :bold, :at =>[10,400]
pdf.text "   : #{notary_day_phone}" , :size => 8, :at =>[75,400]

pdf.text "         Evening #   " , :size => 9, :style => :bold, :at =>[10,388]
pdf.text "   : #{notary_evening_phone}" , :size => 8, :at =>[75,388]

pdf.text "           Mobile #   " , :size => 9, :style => :bold, :at =>[10,376]
pdf.text "   : #{notary_mobile_phone}" , :size => 8, :at =>[75,376]

pdf.text "              Work #   " , :size => 9, :style => :bold, :at =>[10,364]
pdf.text "   : #{notary_work_phone}" , :size => 8, :at =>[75,364]

pdf.text "                Email   " , :size => 9, :style => :bold, :at =>[10,352]
pdf.text "   : #{notary_user_email}" , :size => 8, :at =>[75,352]
end



pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date", :size => 9, :style => :bold, :at => [320,620]
pdf.text "         : #{order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "         : #{order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "         : #{order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "         : #{order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s)   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "         : #{order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs Sent via   ", :size => 9, :style => :bold, :at => [320,560]

if order.shipped_via && order.shipped_via.size!=0
pdf.text "         : #{order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #:   ", :size => 9, :style => :bold, :at => [320,548]

if order.tracking_number && order.tracking_number.size!=0
pdf.text "         : #{order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,548]
end

if order.signing_location_address.length < 36
pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "           #{order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
else
i=536

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
word_wrap(order.signing_location_address,35).split("\n").each() do |loc|
j="          "
if i>=524
pdf.text  j+loc, :size => 9, :at => [385,i]
i=i-12;
end
end
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
end

pdf.text "         : #{order.signing_location_city}, #{order.signing_location_state} #{order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer #1   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "         : #{order.borrower_1_first_name} #{order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #  " , :size => 9, :style => :bold, :at => [320,476]
if order.borrower_1_work_phone.size!=0
pdf.text "         : #{order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,476]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,476]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_1_extension}", :size => 8, :at => [479,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,476]
end


pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,464]
if order.borrower_1_home_phone.size!=0
pdf.text "         : #{order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,452]

if order.borrower_1_mobile_phone.size!=0
pdf.text "         : #{order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer #2    " , :size => 9, :style => :bold, :at => [320,428]
if order.borrower_2_first_name.size!=0 or order.borrower_2_last_name.size!=0
pdf.text "         : #{order.borrower_2_first_name} #{order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                   Work #    " , :size => 9, :style => :bold, :at => [320,416]
if order.borrower_2_work_phone.size!=0
pdf.text "         : #{order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,416]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_2_extension}", :size => 8, :at => [479,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,416]
end

pdf.text "                  Home #   " , :size => 9, :style => :bold, :at => [320,404]
if order.borrower_2_home_phone.size!=0
pdf.text "         : #{order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                 Mobile #   " , :size => 9, :style => :bold, :at => [320,392]
if order.borrower_2_mobile_phone.size!=0
pdf.text "         : #{order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "         : Not Provided", :size => 8, :at => [385,392]
end



pdf.text "Notary Payment Information:", :size => 10, :style => :bold, :at => [0,320]
if notary!=nil
pdf.text "#{notary_billing_payable_to}", :size => 9, :at => [10,305]
pdf.text "#{notary_billing_deliver_address}", :size => 9, :at => [10,293]
pdf.text "#{notary_billing_deliver_city}, #{notary_billing_deliver_state} #{notary_billing_deliver_zip_code}", :size => 9, :at => [10,281]
else
pdf.text "Not Provided", :size => 9, :at => [10,293]
end

pdf.text "Broker/Loan officer Contact Information:", :size => 10, :style => :bold, :at => [300,320]
if agent!=nil
pdf.text "#{agent_company_name}", :size => 9, :at => [320,305]
pdf.text "#{agent_broker_name}", :size => 9, :at => [320,293]
pdf.text "#{agent_address}", :size => 9, :at => [320,281]
pdf.text "#{agent_city}, #{agent_state} #{agent_zip_code}", :size => 9, :at => [320,269]

pdf.text "Telephone #: #{agent_home_phone}", :size => 9, :at => [320,257]

pdf.text "Ext: #{agent_home_extension}", :size => 9, :at => [450,257]

pdf.text "Cell #: #{agent_mobile_phone}", :size => 9, :at => [320,245]

else
pdf.text "Not Provided", :size => 9, :at => [320,293]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,200]

i=180
if order.special_instructions!=nil
word_wrap(order.special_instructions,123).split("\n").each() do |instruction|
if i>=60
pdf.text instruction, :size => 9, :at => [5,i]
i=i-12
end
end
end


pdf.text "For Order Status updates, visit http://www.notaryfly.com", :size => 9, :at => [0,35]
pdf.text "Are there any Lenders,Title or Escrow companies who would benefit from Notaryfly?" , :at => [0,23], :size => 9
pdf.text "Do you know any loan officers or brokers who would need better communication with their loan closings? " , :at => [0,11], :size => 9
pdf.text "If so forward contact info to: referafriend@notaryfly.com", :at => [0,0], :size => 9


   EOS
end


def get_pdf_markup_for_agent(order,agent,notary)

    if agent!=nil
      agent_company_name  = agent.company_name
      agent_broker_name   = agent.broker_name
      agent_address       = agent.address
      agent_city          = agent.city
      agent_state         = agent.state
      agent_zip_code      = agent.zip_code
      agent_home_phone    = agent.home_phone
      
      if agent_home_phone.size==0
        agent_home_phone = "Not Provided"
      end
      agent_home_extension = agent.home_extension

      if agent_home_extension.size==0
        agent_home_extension = "Not Provided"
      end
      agent_mobile_phone  = agent.mobile_phone

      if agent_mobile_phone.size==0
        agent_mobile_phone = "Not Provided"
      end
    end

    if notary!=nil

      notary_address = ""
      notary_city    = ""
      notary_state   = ""
      notary_zipcode = ""

      notary_first_name = order.notary.first_name
      notary_last_name  = order.notary.last_name
      notary_id   = order.notary.id
      notary_day_phone = order.notary.day_phone

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekday"
      notary_address = order.notary.weekday_deliver_address
      notary_city     = order.notary.weekday_deliver_city
      notary_state     = order.notary.weekday_deliver_state
      notary_zipcode  = order.notary.weekday_deliver_zip_code
      end
      
      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekend"
      notary_address = order.notary.weekend_deliver_address
      notary_city     = order.notary.weekend_deliver_city
      notary_state     = order.notary.weekend_deliver_state
      notary_zipcode  = order.notary.weekend_deliver_zip_code
      end

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="payment"
      notary_address  = order.notary.billing_deliver_address
      notary_city     = order.notary.billing_deliver_city
      notary_state     = order.notary.billing_deliver_state
      notary_zipcode  = order.notary.billing_deliver_zip_code
      end



      if notary_day_phone.size==0
        notary_day_phone = "Not Provided"
      end

      notary_evening_phone  = order.notary.evening_phone

       if notary_evening_phone.size==0
        notary_evening_phone = "Not Provided"
      end

      notary_mobile_phone = order.notary.mobile_phone

      if notary_mobile_phone.size==0
        notary_mobile_phone = "Not Provided"
      end

      notary_work_phone = order.notary.work_phone

      if notary_work_phone.size==0
        notary_work_phone = "Not Provided"
      end
      notary_user_email = order.notary.user.email

     notary_billing_payable_to = order.notary.billing_payable_to
     notary_billing_deliver_address = order.notary.billing_deliver_address
     notary_billing_deliver_city  = order.notary.billing_deliver_city
     notary_billing_deliver_state = order.notary.billing_deliver_state
     notary_billing_deliver_zip_code = order.notary.billing_deliver_zip_code
    end

    return <<-EOS
    pdf.stroke_rectangle [0,635], 250, 270
pdf.stroke_rectangle [300,635], 250, 270


pdf.stroke_rectangle [0,335], 550, 85
#pdf.stroke_rectangle [300,335], 250, 85

pdf.stroke_rectangle [0,230], 550,172

pdf.text "NotaryFLY.com", :at => [0,700], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,700], :size => 17, :style => :bold
pdf.move_down(30)
pdf.text "For Order Status updates, visit http://www.notaryfly.com", :at => [5,665], :size => 8


pdf.move_down(15)

pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "      NF Order # ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text ": #{order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow # "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text ": #{order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text ": #{order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text ": #{order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{order.client.address}" , :size => 8, :at =>[75,576]
pdf.text "    #{order.client.city} , #{order.client.state} #{order.client.zip_code}" , :size => 8, :at =>[75,568]
pdf.text "  Contact Name  " , :size => 9, :style => :bold, :at =>[10,556]

if order.client.client_name.size!=0
pdf.text "  : #{order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #  ", :size => 9, :style => :bold, :at =>[10,544]

if order.client.home_phone.size!=0
pdf.text "  : #{order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext # ", :size => 9, :style => :bold, :at =>[150,544]

if order.client.home_extension.size!=0
pdf.text "  : #{order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #  " , :size => 9, :style => :bold, :at =>[10,532]

if order.client.direct_phone.size!=0
pdf.text "  : #{order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #  " , :size => 9, :style => :bold, :at =>[10,520]

if order.client.mobile_phone.size!=0
pdf.text "  : #{order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,520]
end


if notary!=nil
pdf.text "               Notary  " , :size => 9, :style => :bold, :at =>[10,508]
pdf.text "  : #{notary_first_name} #{notary_last_name}" , :size => 8, :at =>[75,508]
pdf.text "    Doc Delivery" , :size => 9, :style => :bold, :at =>[10,496]
pdf.text "  : #{notary_address}" , :size => 8, :at =>[75,496]
pdf.text "           Address " , :size => 9, :style => :bold, :at =>[10,484]
pdf.text "  : #{notary_city}, #{notary_state} #{notary_zipcode}" , :size => 8, :at =>[75,484]
pdf.text "  NotaryFly ID #  " , :size => 9, :style => :bold, :at =>[10,472]
pdf.text "  : #{notary_id}" , :size => 8, :at =>[75,472]
pdf.text "                 Day #  " , :size => 9, :style => :bold, :at =>[10,460]
pdf.text "  : #{notary_day_phone}" , :size => 8, :at =>[75,460]

pdf.text "         Evening #   " , :size => 9, :style => :bold, :at =>[10,448]
pdf.text "  : #{notary_evening_phone}" , :size => 8, :at =>[75,448]

pdf.text "           Mobile #   " , :size => 9, :style => :bold, :at =>[10,436]
pdf.text "  : #{notary_mobile_phone}" , :size => 8, :at =>[75,436]

pdf.text "              Work #   " , :size => 9, :style => :bold, :at =>[10,424]
pdf.text "  : #{notary_work_phone}" , :size => 8, :at =>[75,424]

pdf.text "                Email   " , :size => 9, :style => :bold, :at =>[10,412]
pdf.text "  : #{notary_user_email}" , :size => 8, :at =>[75,412]
end


pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date", :size => 9, :style => :bold, :at => [320,620]
pdf.text "      : #{order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "      : #{order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "      : #{order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "      : #{order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s)   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "      : #{order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs Sent via   ", :size => 9, :style => :bold, :at => [320,560]

if order.shipped_via && order.shipped_via.size!=0
pdf.text "      : #{order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #   ", :size => 9, :style => :bold, :at => [320,548]

if order.tracking_number && order.tracking_number.size!=0
pdf.text "      : #{order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,548]
end

if order.signing_location_address && order.signing_location_address.length < 36
pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "         #{order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
else
i=536

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
word_wrap(order.signing_location_address,35).split("\n").each() do |loc|
j="       "
if i>=524
pdf.text  j+loc, :size => 9, :at => [385,i]
i=i-12;
end
end
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
end

pdf.text "      : #{order.signing_location_city}, #{order.signing_location_state} #{order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer #1   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "      : #{order.borrower_1_first_name} #{order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #   " , :size => 9, :style => :bold, :at => [320,476]
if order.borrower_1_work_phone.size!=0
pdf.text "      : #{order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,476]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,476]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_1_extension}", :size => 8, :at => [479,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,476]
end

pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,464]
if order.borrower_1_home_phone.size!=0
pdf.text "      : #{order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,452]

if order.borrower_1_mobile_phone.size!=0
pdf.text "      : #{order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer #2    " , :size => 9, :style => :bold, :at => [320,428]
if order.borrower_2_first_name.size!=0 or order.borrower_2_last_name.size!=0
pdf.text "      : #{order.borrower_2_first_name} #{order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                   Work #    " , :size => 9, :style => :bold, :at => [320,416]
if order.borrower_2_work_phone.size!=0
pdf.text "      : #{order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,416]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_2_extension}", :size => 8, :at => [479,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,416]
end

pdf.text "                  Home #   " , :size => 9, :style => :bold, :at => [320,404]
if order.borrower_2_home_phone.size!=0
pdf.text "      : #{order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                 Mobile #   " , :size => 9, :style => :bold, :at => [320,392]
if order.borrower_2_mobile_phone.size!=0
pdf.text "      : #{order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,392]
end




pdf.text "Broker/Loan officer Contact Information:", :size => 10, :style => :bold, :at => [0,340]
if agent!=nil
pdf.text "#{agent_company_name}", :size => 9, :at => [10,320]
pdf.text "#{agent_broker_name}", :size => 9, :at => [10,308]
pdf.text "#{agent_address}", :size => 9, :at => [10,296]
pdf.text "#{agent_city}, #{agent_state} #{agent_zip_code}", :size => 9, :at => [10,284]

pdf.text "Telephone #: #{agent_home_phone}", :size => 9, :at => [10,272]

pdf.text "Ext: #{agent_home_extension}", :size => 9, :at => [140,272]

pdf.text "Cell #: #{agent_mobile_phone}", :size => 9, :at => [10,260]

else
pdf.text "Not Provided", :size => 9, :at => [10,296]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,235]

i=220
if order.special_instructions!=nil
word_wrap(order.special_instructions,123).split("\n").each() do |instruction|
if i>=64
pdf.text instruction, :size => 9, :at => [5,i]
i=i-12
end
end
end


pdf.text "Are there any Lenders,Title or Escrow companies who would benefit from Notaryfly?", :size => 9, :at => [0,35]
pdf.text "Do you know any loan officers or brokers who would need better communication with their loan closings? " , :at => [0,23], :size => 9
pdf.text "If so forward contact info to: referafriend@notaryfly.com", :at => [0,11], :size => 9




    EOS
  end

def get_pdf_complete_order(order,agent,notary)

    if agent!=nil
      agent_company_name  = agent.company_name
      agent_broker_name   = agent.broker_name
      agent_address       = agent.address
      agent_city          = agent.city
      agent_state         = agent.state
      agent_zip_code      = agent.zip_code
      agent_home_phone    = agent.home_phone
      
      if agent_home_phone.size==0
        agent_home_phone = "Not Provided"
      end
      agent_home_extension = agent.home_extension

      if agent_home_extension.size==0
        agent_home_extension = "Not Provided"
      end
      agent_mobile_phone  = agent.mobile_phone

      if agent_mobile_phone.size==0
        agent_mobile_phone = "Not Provided"
      end
    end

    if notary!=nil

      notary_address = ""
      notary_city    = ""
      notary_state   = ""
      notary_zipcode = ""

      notary_first_name = order.notary.first_name
      notary_last_name  = order.notary.last_name
      notary_id   = order.notary.id
      notary_day_phone = order.notary.day_phone

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekday"
      notary_address = order.notary.weekday_deliver_address
      notary_city     = order.notary.weekday_deliver_city
      notary_state     = order.notary.weekday_deliver_state
      notary_zipcode  = order.notary.weekday_deliver_zip_code
      end
      
      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="weekend"
      notary_address = order.notary.weekend_deliver_address
      notary_city     = order.notary.weekend_deliver_city
      notary_state     = order.notary.weekend_deliver_state
      notary_zipcode  = order.notary.weekend_deliver_zip_code
      end

      if order.doc_delivery_address_option==nil or order.doc_delivery_address_option=="payment"
      notary_address  = order.notary.billing_deliver_address
      notary_city     = order.notary.billing_deliver_city
      notary_state     = order.notary.billing_deliver_state
      notary_zipcode  = order.notary.billing_deliver_zip_code
      end



      if notary_day_phone.size==0
        notary_day_phone = "Not Provided"
      end

      notary_evening_phone  = order.notary.evening_phone

       if notary_evening_phone.size==0
        notary_evening_phone = "Not Provided"
      end

      notary_mobile_phone = order.notary.mobile_phone

      if notary_mobile_phone.size==0
        notary_mobile_phone = "Not Provided"
      end

      notary_work_phone = order.notary.work_phone

      if notary_work_phone.size==0
        notary_work_phone = "Not Provided"
      end
      notary_user_email = order.notary.user.email

     notary_billing_payable_to = order.notary.billing_payable_to
     notary_billing_deliver_address = order.notary.billing_deliver_address
     notary_billing_deliver_city  = order.notary.billing_deliver_city
     notary_billing_deliver_state = order.notary.billing_deliver_state
     notary_billing_deliver_zip_code = order.notary.billing_deliver_zip_code
    end

    return <<-EOS
    pdf.stroke_rectangle [0,635], 250, 290
pdf.stroke_rectangle [300,635], 250, 270


pdf.stroke_rectangle [0,335], 250, 85
pdf.stroke_rectangle [300,335], 250, 85

pdf.stroke_rectangle [0,230], 550, 100

pdf.text "NotaryFLY.com", :at => [0,700], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,700], :size => 17, :style => :bold
pdf.move_down(30)
pdf.text "Please visit http://www.notaryfly.com and login with your username and", :at => [5,665], :size => 8
pdf.text "password so you can provide up to date status on the signing.", :at => [5,655], :size => 8

pdf.move_down(15)

pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "       NF Order #: ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text "  #{order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow #: "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text "  #{order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date: "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text "  #{order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By: " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text "  #{order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{order.client.address}" , :size => 8, :at =>[75,576]
pdf.text "    #{order.client.city} , #{order.client.state} #{order.client.zip_code}" , :size => 8, :at =>[75,568]
pdf.text "  Contact Name:  " , :size => 9, :style => :bold, :at =>[10,556]

if order.client.client_name.size!=0
pdf.text "   #{order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #:  ", :size => 9, :style => :bold, :at =>[10,544]

if order.client.home_phone.size!=0
pdf.text "   #{order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext #: ", :size => 9, :style => :bold, :at =>[150,544]

if order.client.home_extension.size!=0
pdf.text "   #{order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "   Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #:  " , :size => 9, :style => :bold, :at =>[10,532]

if order.client.direct_phone.size!=0
pdf.text "   #{order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #:  " , :size => 9, :style => :bold, :at =>[10,520]

if order.client.mobile_phone.size!=0
pdf.text "   #{order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,520]
end


if notary!=nil
pdf.text "               Notary:  " , :size => 9, :style => :bold, :at =>[10,508]
pdf.text "   #{notary_first_name} #{notary_last_name}" , :size => 8, :at =>[75,508]
pdf.text "    Doc Delivery" , :size => 9, :style => :bold, :at =>[10,496]
pdf.text "   #{notary_address}" , :size => 8, :at =>[75,496]
pdf.text "           Address :" , :size => 9, :style => :bold, :at =>[10,484]
pdf.text "   #{notary_city}, #{notary_state} #{notary_zipcode}" , :size => 8, :at =>[75,484]
pdf.text "  NotaryFly ID #:  " , :size => 9, :style => :bold, :at =>[10,472]
pdf.text "   #{notary_id}" , :size => 8, :at =>[75,472]
pdf.text "      Signing Fee:  " , :size => 9, :style => :bold, :at =>[10,460]

if !order.signing_fee.blank?
pdf.text "   $#{number_with_precision(order.signing_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,460]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,460]
end

pdf.text "      Other Fee:  " , :size => 9, :style => :bold, :at =>[10,448]

if order.travel_fee!=nil
pdf.text "   $#{number_with_precision(order.travel_fee,:precision=>2)}" , :size => 8, :at =>[75,448]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,448]
end

pdf.text "      Explanation   :  " , :size => 9, :style => :bold, :at =>[10,436]
i=436
if order.other_fee_reason!=nil
word_wrap(order.other_fee_reason,44).split("\n").each() do |explanation|
  j="  "
pdf.text  j+explanation, :size => 9, :at => [83,i]
i=i-12
end
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,436]
end

pdf.text " Total Signing Fee:  " , :size => 9, :style => :bold, :at =>[10,412]

if !order.signing_fee.blank? && order.travel_fee!=nil
 pdf.text "   $#{number_with_precision(order.signing_fee.to_f + order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[80,412]
elsif !order.signing_fee.blank? && order.travel_fee==nil
pdf.text "   $#{number_with_precision(order.signing_fee.to_f,:precision=>2)}" , :size => 8, :at =>[80,412]
elsif order.signing_fee.blank? && order.travel_fee!=nil
pdf.text "   $#{number_with_precision(order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[80,412]
else
pdf.text "   $0.00" , :size => 8, :at =>[80,412]
end

pdf.text "Payment to NotaryFly: ", :size => 9, :style => :bold, :at =>[10,400]

if !order.signing_fee.blank? && order.travel_fee!=nil
 pdf.text "   $#{order.signing_fee.to_f + order.travel_fee.to_f}" , :size => 8, :at =>[90,400]
elsif !order.signing_fee.blank? && order.travel_fee==nil
pdf.text "   $#{order.signing_fee.to_f}" , :size => 8, :at =>[90,400]
elsif order.signing_fee.blank? && order.travel_fee!=nil
pdf.text "   $#{order.travel_fee.to_f}" , :size => 8, :at =>[90,400]
else
pdf.text "   $0.00" , :size => 8, :at =>[90,412]
end

pdf.text "Balance:" , :size => 9, :style => :bold, :at =>[10,388]
pdf.text "$0.00" ,:size => 8, :at =>[90,388]
pdf.text "                 Day #:  " , :size => 9, :style => :bold, :at =>[10,376]
pdf.text "   #{notary_day_phone}" , :size => 8, :at =>[75,376]

pdf.text "         Evening #:   " , :size => 9, :style => :bold, :at =>[10,364]
pdf.text "   #{notary_evening_phone}" , :size => 8, :at =>[75,364]

pdf.text "           Mobile #:   " , :size => 9, :style => :bold, :at =>[10,352]
pdf.text "   #{notary_mobile_phone}" , :size => 8, :at =>[75,352]

pdf.text "              Work #:   " , :size => 9, :style => :bold, :at =>[10,340]
pdf.text "   #{notary_work_phone}" , :size => 8, :at =>[75,340]

pdf.text "                Email:   " , :size => 9, :style => :bold, :at =>[10,328]
pdf.text "   #{notary_user_email}" , :size => 8, :at =>[75,328]
end



pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date:", :size => 9, :style => :bold, :at => [320,620]
pdf.text "       #{order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time: ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "       #{order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type:  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "       #{order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option:  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "       #{order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s):   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "       #{order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs Sent via:   ", :size => 9, :style => :bold, :at => [320,560]

if order.shipped_via.size!=0
pdf.text "       #{order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "       Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #:   ", :size => 9, :style => :bold, :at => [320,548]

if order.tracking_number.size!=0
pdf.text "       #{order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "       Not Provided", :size => 8, :at => [385,548]
end


if order.signing_location_address.length < 36
pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "         #{order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
else
i=536

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
word_wrap(order.signing_location_address,35).split("\n").each() do |loc|
j="        "
if i>=524
pdf.text  j+loc, :size => 9, :at => [385,i]
i=i-12;
end
end
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
end

pdf.text "      : #{order.signing_location_city}, #{order.signing_location_state} #{order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer #1:   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "         #{order.borrower_1_first_name} #{order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #:   " , :size => 9, :style => :bold, :at => [320,476]
if order.borrower_1_work_phone.size!=0
pdf.text "         #{order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "         Not Provided", :size => 8, :at => [385,476]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,476]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_1_extension}", :size => 8, :at => [479,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,476]
end


pdf.text "                 Home #:   " , :size => 9, :style => :bold, :at => [320,464]
if order.borrower_1_home_phone.size!=0
pdf.text "         #{order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "         Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #:   " , :size => 9, :style => :bold, :at => [320,452]

if order.borrower_1_mobile_phone.size!=0
pdf.text "         #{order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "         Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer #2:    " , :size => 9, :style => :bold, :at => [320,428]
if order.borrower_2_first_name.size!=0 or order.borrower_2_last_name.size!=0
pdf.text "         #{order.borrower_2_first_name} #{order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "         Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                   Work #:    " , :size => 9, :style => :bold, :at => [320,416]
if order.borrower_2_work_phone.size!=0
pdf.text "         #{order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "         Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,416]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_2_extension}", :size => 8, :at => [479,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,416]
end

pdf.text "                  Home #:   " , :size => 9, :style => :bold, :at => [320,404]
if order.borrower_2_home_phone.size!=0
pdf.text "         #{order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "         Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                 Mobile #:   " , :size => 9, :style => :bold, :at => [320,392]
if order.borrower_2_mobile_phone.size!=0
pdf.text "         #{order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "         Not Provided", :size => 8, :at => [385,392]
end



pdf.text "Notary Payment Information:", :size => 10, :style => :bold, :at => [0,340]
if notary!=nil
pdf.text "#{notary_billing_payable_to}", :size => 9, :at => [10,320]
pdf.text "#{notary_billing_deliver_address}", :size => 9, :at => [10,308]
pdf.text "#{notary_billing_deliver_city}, #{notary_billing_deliver_state} #{notary_billing_deliver_zip_code}", :size => 9, :at => [10,296]
else
pdf.text "Not Provided", :size => 9, :at => [10,308]
end

pdf.text "Broker/Loan officer Contact Information:", :size => 10, :style => :bold, :at => [300,340]
if agent!=nil
pdf.text "#{agent_company_name}", :size => 9, :at => [320,320]
pdf.text "#{agent_broker_name}", :size => 9, :at => [320,308]
pdf.text "#{agent_address}", :size => 9, :at => [320,296]
pdf.text "#{agent_city}, #{agent_state} #{agent_zip_code}", :size => 9, :at => [320,284]

pdf.text "Telephone #: #{agent_home_phone}", :size => 9, :at => [320,272]

pdf.text "Ext: #{agent_home_extension}", :size => 9, :at => [450,272]

pdf.text "Cell #: #{agent_mobile_phone}", :size => 9, :at => [320,260]

else
pdf.text "Not Provided", :size => 9, :at => [320,296]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,235]

i=220
if order.special_instructions!=nil
word_wrap(order.special_instructions,130).split("\n").each() do |instruction|
pdf.text instruction, :size => 9, :at => [5,i]
i=i-12
end
end


pdf.text "For Order Status updates, visit http://www.notaryfly.com.Are there any Lenders,Title or Escrow companies who would benefit from notaryfly?", :size => 9, :at => [0,95]
pdf.text "Do you know any loan officers or brokers who would need better communication with their loan closings? " , :at => [0,83], :size => 9
pdf.text "If so forward contact info to: referafriend@notaryfly.com", :at => [0,71], :size => 9




    EOS
  end




  def get_pdf_markup_for_notary(order,agent,notary)

    if agent!=nil
      agent_company_name  = agent.company_name
      agent_broker_name   = agent.broker_name
      agent_address       = agent.address
      agent_city          = agent.city
      agent_state         = agent.state
      agent_zip_code      = agent.zip_code
      agent_home_phone    = agent.home_phone

      if agent_home_phone.size==0
        agent_home_phone = "Not Provided"
      end
      agent_home_extension = agent.home_extension

      if agent_home_extension.size==0
        agent_home_extension = "Not Provided"
      end
      agent_mobile_phone  = agent.mobile_phone

      if agent_mobile_phone.size==0
        agent_mobile_phone = "Not Provided"
      end
    end

    if notary!=nil
      notary_first_name = order.notary.first_name
      notary_last_name  = order.notary.last_name
      notary_id   = order.notary.id
      notary_day_phone = order.notary.day_phone
      
      #if order.special_instructions!=nil
	#special_instruction=word_wrap(order.special_instructions,20)
	#special_instruction=instruction.to_a.split('\n').flatten.map!{ |element| element.gsub(/\n/, '') }
      #end
      if notary_day_phone.size==0
        notary_day_phone = "Not Provided"
      end

      notary_evening_phone  = order.notary.evening_phone

       if notary_evening_phone.size==0
        notary_evening_phone = "Not Provided"
      end

      notary_mobile_phone = order.notary.mobile_phone

      if notary_mobile_phone.size==0
        notary_mobile_phone = "Not Provided"
      end

      notary_work_phone = order.notary.work_phone

      if notary_work_phone.size==0
        notary_work_phone = "Not Provided"
      end
      notary_user_email = order.notary.user.email
      notary_user_user_password   = order.notary.user.user_password
     notary_billing_payable_to = order.notary.billing_payable_to
     notary_billing_deliver_address = order.notary.billing_deliver_address
     notary_billing_deliver_city  = order.notary.billing_deliver_city
     notary_billing_deliver_state = order.notary.billing_deliver_state
     notary_billing_deliver_zip_code = order.notary.billing_deliver_zip_code
    end

    pdf_text = <<-EOS

pdf.stroke_rectangle [0,635], 250, 270
pdf.stroke_rectangle [300,635], 250, 270


pdf.stroke_rectangle [0,335], 250, 85
pdf.stroke_rectangle [300,335], 250, 85

pdf.stroke_rectangle [0,230], 550, 172

pdf.text "NotaryFLY.com", :at => [0,720], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,720], :size => 17, :style => :bold
pdf.move_down(30)
#pdf.text "Please visit http://www.notaryfly.com and login with your username and", :at => [5,665], :size => 8
#pdf.text "password so you can provide up to date status on the signing.", :at => [5,655], :size => 8
#pdf.move_down(15)

pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "      NF Order # ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text ": #{order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow # "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text ": #{order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text ": #{order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text ": #{order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{order.client.address}" , :size => 8, :at =>[75,576]
pdf.text "    #{order.client.city} , #{order.client.state} #{order.client.zip_code}" , :size => 8, :at =>[75,568]
pdf.text "  Contact Name  " , :size => 9, :style => :bold, :at =>[10,556]

if order.client.client_name.size!=0
pdf.text "  : #{order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #  ", :size => 9, :style => :bold, :at =>[10,544]

if order.client.home_phone.size!=0
pdf.text "  : #{order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext # ", :size => 9, :style => :bold, :at =>[150,544]

if order.client.home_extension.size!=0
pdf.text "  : #{order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #  " , :size => 9, :style => :bold, :at =>[10,532]

if order.client.direct_phone.size!=0
pdf.text "  : #{order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #  " , :size => 9, :style => :bold, :at =>[10,520]

if order.client.mobile_phone.size!=0
pdf.text "  : #{order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,520]
end


if notary!=nil
pdf.text "               Notary  " , :size => 9, :style => :bold, :at =>[10,508]
pdf.text "  : #{notary_first_name} #{notary_last_name}" , :size => 8, :at =>[75,508]
pdf.text "  NotaryFly ID #  " , :size => 9, :style => :bold, :at =>[10,496]
pdf.text "  : #{notary_id}" , :size => 8, :at =>[75,496]
pdf.text "      Notary Fee  " , :size => 9, :style => :bold, :at =>[10,484]

if order.notary_fee!=nil
pdf.text "  : $#{number_with_precision(order.notary_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,484]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,484]
end
pdf.text "      Other Fee  " , :size => 9, :style => :bold, :at =>[10,472]
if order.travel_fee!=nil
pdf.text "  : $#{number_with_precision(order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,472]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,472]
end
pdf.text "      Explanation : " , :size => 9, :style => :bold, :at =>[10,460]
i=460
if order.other_fee_reason!=nil
word_wrap(order.other_fee_reason,35).split("\n").each() do |explanation|
  if i>=448
 pdf.text explanation, :size => 9, :at => [83,i]
 i=i-12
end
end
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,448]
end
pdf.text "Total Notary Fee  " , :size => 9, :style => :bold, :at =>[8,436]

if order.notary_fee!=nil && order.travel_fee!=nil
 pdf.text "  : $#{number_with_precision(order.notary_fee.to_f + order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
elsif order.notary_fee!=nil && order.travel_fee==nil
pdf.text "  : $#{number_with_precision(order.notary_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
elsif order.notary_fee==nil && order.travel_fee!=nil
pdf.text "  : $#{number_with_precision(order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
else
pdf.text "  : $ 0.00" , :size => 8, :at =>[75,436]
end


pdf.text "                 Day #  " , :size => 9, :style => :bold, :at =>[10,424]
pdf.text "  : #{notary_day_phone}" , :size => 8, :at =>[75,424]

pdf.text "         Evening #   " , :size => 9, :style => :bold, :at =>[10,412]
pdf.text "  : #{notary_evening_phone}" , :size => 8, :at =>[75,412]

pdf.text "           Mobile #   " , :size => 9, :style => :bold, :at =>[10,400]
pdf.text "  : #{notary_mobile_phone}" , :size => 8, :at =>[75,400]

pdf.text "              Work #   " , :size => 9, :style => :bold, :at =>[10,388]
pdf.text "  : #{notary_work_phone}" , :size => 8, :at =>[75,388]


pdf.text "                Email   " , :size => 9, :style => :bold, :at =>[10,376]
pdf.text "  : #{notary_user_email}" , :size => 8, :at =>[75,376]
end



pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date", :size => 9, :style => :bold, :at => [320,620]
pdf.text "      : #{order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "      : #{order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "      : #{order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "      : #{order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s)   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "      : #{order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs Sent via   ", :size => 9, :style => :bold, :at => [320,560]

if order.shipped_via && order.shipped_via.size!=0
pdf.text "      : #{order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #   ", :size => 9, :style => :bold, :at => [320,548]

if order.tracking_number && order.tracking_number.size!=0
pdf.text "      : #{order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,548]
end

if order.signing_location_address && order.signing_location_address.length < 36
pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "         #{order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
else
i=536

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
word_wrap(order.signing_location_address,35).split("\n").each() do |loc|
j="       "
if i>=524
pdf.text  j+loc, :size => 9, :at => [385,i]
i=i-12;
end
end
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
end

pdf.text "      : #{order.signing_location_city}, #{order.signing_location_state} #{order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer #1   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "      : #{order.borrower_1_first_name} #{order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #   " , :size => 9, :style => :bold, :at => [320,476]
if order.borrower_1_work_phone.size!=0
pdf.text "      : #{order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,476]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,476]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_1_extension}", :size => 8, :at => [479,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,476]
end

pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,464]
if order.borrower_1_home_phone.size!=0
pdf.text "      : #{order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,452]

if order.borrower_1_mobile_phone.size!=0
pdf.text "      : #{order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer #2    " , :size => 9, :style => :bold, :at => [320,428]
if order.borrower_2_first_name.size!=0 or order.borrower_2_last_name.size!=0
pdf.text "      : #{order.borrower_2_first_name} #{order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                  Work #    " , :size => 9, :style => :bold, :at => [320,416]
if order.borrower_2_work_phone.size!=0
pdf.text "      : #{order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,416]
if order.borrower_1_extension.size!=0
pdf.text "      : #{order.borrower_2_extension}", :size => 8, :at => [479,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,416]
end

pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,404]
if order.borrower_2_home_phone.size!=0
pdf.text "      : #{order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,392]
if order.borrower_2_mobile_phone.size!=0
pdf.text "      : #{order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,392]
end



pdf.text "Return Documents To:", :size => 10, :style => :bold, :at => [0,340]
pdf.text "#{order.return_company_name}", :size => 9, :at => [10,320]
pdf.text "Attn : #{order.return_attention}", :size => 9, :at => [10,308]
pdf.text "#{order.return_address}", :size => 9, :at => [10,296]
pdf.text "#{order.return_city}, #{order.return_state} #{order.return_zip_code}", :size => 9, :at => [10,284]
pdf.text "#{order.return_shipping_courier} Acct#: #{order.return_account_number}", :size => 9, :at => [10,272]

pdf.text "Broker/Loan Officer Contact Information:", :size => 10, :style => :bold, :at => [300,340]
if agent!=nil
pdf.text "#{agent_company_name}", :size => 9, :at => [320,320]
pdf.text "#{agent_broker_name}", :size => 9, :at => [320,308]
pdf.text "#{agent_address}", :size => 9, :at => [320,296]
pdf.text "#{agent_city}, #{agent_state} #{agent_zip_code}", :size => 9, :at => [320,284]

pdf.text "Telephone #: #{agent_home_phone}", :size => 9, :at => [320,272]

pdf.text "Ext: #{agent_home_extension}", :size => 9, :at => [450,272]

pdf.text "Cell #: #{agent_mobile_phone}", :size => 9, :at => [320,260]

else
pdf.text "Not Provided", :size => 9, :at => [320,296]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,235]

i=220
if order.special_instructions!=nil
word_wrap(order.special_instructions,123).split("\n").each() do |instruction|
if i>64
pdf.text instruction, :size => 9, :at => [5,i]
i=i-12
end
end
end


pdf.text "For Order Status updates, visit http://www.notaryfly.com", :size => 9, :at => [0,35]
pdf.text "Are there any Lenders,Title or Escrow companies who would benefit from Notaryfly?" , :at => [0,23], :size => 9
pdf.text "Do you know any loan officers or brokers who would need better communication with their loan closings? " , :at => [0,11], :size => 9
pdf.text "If so forward contact info to: referafriend@notaryfly.com", :at => [0,0], :size => 9
    EOS
	return pdf_text
  end



 def notary_credits_purchase(client_name,invoice_no,purchase_amount,promo,new_amount,email)
    # Email header info MUST be added here

      @recipients = email
    
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "NotaryFly - More credits purchased details"
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:name=> client_name,:invoice=> invoice_no, :purchase_amount=>purchase_amount,:promo=>promo,:total_credits=>new_amount}
  end

  def admin_message(client_name,email,password)
    # Email header info MUST be added here

      @recipients = email

    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "You have received a message from Notary FLY."
    content_type 'text/html'   #    <== note this line
    # Email body substitutions go here
    @body = {:name=> client_name,:username=> email,:pass=> password}
  end

  def client_order_placed(order, client_email)

    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "(#{order.borrower_1_last_name.capitalize}) NF ##{order.id} - ESC ##{order.loan_number}: PLACED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end

  def client_invoice_paid(order, client_email)

    @notary = order.notary
    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "(#{order.borrower_1_last_name.capitalize}) NF ##{order.id} - ESC ##{order.loan_number}: Invoice PAID"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end
  def client_order_completed_by_admin(order, client_email)

    # Email header info MUST be added here
    @recipients = client_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "(#{order.borrower_1_last_name.capitalize}) NF ##{order.id} - ESC ##{order.loan_number}: COMPLETED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end
  def client_assign_order_confirmation(order, notary, client_email)
  
    @notary = notary
    @recipients = client_email
    from  "noreply@notaryfly.com"
    @subject = "(#{order.borrower_1_last_name.capitalize}) NF ##{order.id} - ESC ##{order.loan_number}:  Notary ASSIGNED"
    content_type 'multipart/mixed'   #    <== note this line
  
    # Email body substitutions go here
     @body = {:order => order}
  
    #Create file
    filename = create_pdf_file_for_notary(order,order.agent,notary)
    
    part :content_type => "text/html", :body =>
        render_message('client_assign_order_confirmation', :order => order)
  attachment :content_type => "application/pdf", :filename=> "NFWorkOrder.pdf",
             :body => File.read(RAILS_ROOT + "/tmp/invoice-#{order.id}.pdf")
  
  if !order.special_instructions.blank?
    sp_filename = create_pdf_file_for_spinstruction(order)
    attachment :content_type => "application/pdf", :filename=> "special_instructions.pdf",
               :body => File.read(RAILS_ROOT + "/tmp/specialinstructions-#{order.id}.pdf")
  end
  #Attachment 2#
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_1_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  
  if !order.order_attachment_2_file_name.nil? && order.order_attachment_2_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_2_file_name}",
               :body => File.read(order.order_attachment_2.path)
  end
  #Attachment 3 #
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  
  if !order.order_attachment_3_file_name.nil? && order.order_attachment_3_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_3_file_name}",
               :body => File.read(order.order_attachment_3.path)
  end
  #Attachment 4 #
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  if !order.order_attachment_4_file_name.nil? && order.order_attachment_4_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_4_file_name}",
               :body => File.read(order.order_attachment_4.path)
  end
  
  #Attachment 5 #
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  
  if !order.order_attachment_5_file_name.nil? && order.order_attachment_5_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_5_file_name}",
               :body => File.read(order.order_attachment_5.path)
  end
  
  #Attachment 6 #
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpeg"
    attachment :content_type => "image/jpeg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/jpg"
    attachment :content_type => "image/jpg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/png"
    attachment :content_type => "image/png",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/pjpeg"
    attachment :content_type => "image/pjpeg",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "image/x-png"
    attachment :content_type => "image/x-png",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/msword"
    attachment :content_type => "application/msword",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/octet-stream"
    attachment :content_type => "application/octet-stream",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.wordprocessingml.document",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/pdf"
    attachment :content_type => "application/pdf",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/word"
    attachment :content_type => "application/word",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    attachment :content_type => "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.oasis.opendocument.text"
    attachment :content_type => "application/vnd.oasis.opendocument.text",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  
  if !order.order_attachment_6_file_name.nil? && order.order_attachment_6_content_type == "application/vnd.ms-powerpoint"
    attachment :content_type => "application/vnd.ms-powerpoint",:filename=> "#{order.order_attachment_6_file_name}",
               :body => File.read(order.order_attachment_6.path)
  end
  end
  def notary_order_completed_by_admin(order, notary_email)

    # Email header info MUST be added here
    @recipients = notary_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "NF Order ##{order.id} (#{order.borrower_1_last_name.capitalize}): Order COMPLETED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end
  def agent_order_placed(order, agent_email)
    @agent = order.agent
    # Email header info MUST be added here
    @recipients = agent_email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    @subject = "(#{order.borrower_1_last_name.capitalize}) NF ##{order.id} - ESC ##{order.loan_number}: PLACED"
    content_type 'text/html'   #    <== note this line

    # Email body substitutions go here
    @body = {:order => order}
  end
  def agent_assign_order_confirmation(order, agent_email)
    @agent = order.agent 
    @recipients = agent_email
    from  "noreply@notaryfly.com"
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}):  Notary ASSIGNED"
    content_type 'text/html'   #    <== note this line
  
    # Email body substitutions go here
     @body = {:order => order}
  end
  def agent_appointment_confirmation(order, agent_email)
    @agent = order.agent
    @recipients = agent_email
    from  "noreply@notaryfly.com"
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}): APPT CONFIRMED"
    content_type 'text/html'   #    <== note this line
  
    # Email body substitutions go here
     @body = {:order => order}
  end
  def agent_signing_completed(order, agent_email)
    @agent = order.agent 
    @recipients = agent_email
    from  "noreply@notaryfly.com"
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}): Signing COMPLETED"
    content_type 'text/html'   #    <== note this line
  
    # Email body substitutions go here
     @body = {:order => order}
  end
  def agent_Loan_funded(order, agent_email)
    @agent = order.agent 
    @recipients = agent_email
    from  "noreply@notaryfly.com"
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}): Your Loan has FUNDED"
    content_type 'text/html'   #    <== note this line
  
    # Email body substitutions go here
     @body = {:order => order}
  end
  def agent_feedback_mail(order,agent)

    @recipients = agent.email
    # @recipients = "dominic@19villages.com"
    from  "noreply@notaryfly.com"
    content_type 'text/html'   #    <== note this line
    @subject = "NF ##{order.id} (#{order.borrower_1_last_name.capitalize}): FEEDBACK on NOTARY??"

    # Email body substitutions go here
    @body = {:order => order}

  end
end
