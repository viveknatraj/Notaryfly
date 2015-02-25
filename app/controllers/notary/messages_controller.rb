class Notary::MessagesController < ApplicationController
 before_filter :require_login_notary
  def index
    if params[:id].nil?
      @messages = Message.find(:all, :conditions => ["recipient_id = ?", self.current_user.id], :order => "created_at DESC")
    else
      @messages = Message.find(:all, :conditions => ["recipient_id = ? AND order_id = ?", self.current_user.id,params[:id]], :order => "created_at DESC")
    end
  end
  
  def sent
    @messages = Message.find(:all, :conditions => ["user_id = ? AND hide_from_sender IS NOT true", self.current_user.id], :order => "created_at DESC")
  end
  
  def new
    @order = Order.find(params[:id])
    @message = Message.new
  end
  
  def create
    @message = Message.new(params[:message])
    @order = Order.find(params[:message][:order_id])
    @message.user_id = self.current_user.id
    @message.is_unread = true
    @message.recipient_id = @order.client.user_id
    if @message.save
     @client = Client.find(@order.client_id)
      client_email = User.find(@client.user_id)
      client_email = client_email.email
      Notifier.deliver_client_new_message_recipient(@order,client_email) #client_email
      redirect_to(:action => 'index')
    end

    
  end
  
  def detail
    @message = Message.find(params[:id])
    @message.update_attribute(:is_unread, false)
    @client = Client.find_by_user_id(@message.user_id)
  end
  
  def sent_detail
    @message = Message.find(params[:id])
    @client = Client.find_by_user_id(@message.recipient_id)  
  end
  
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to :action => "index"
  end
  
  def mark_sent_as_read
    @message = Message.find(params[:id])
    @message.update_attribute(:hide_from_sender, true)
    redirect_to :action => "sent"
  end

   def delete_attachment
  msg_id = ""
    @client = Message.find(:all,:conditions => ["recipient_id = ? AND order_id = ?", self.current_user.id,params[:order_id]])
   for c in @client
     msg_id = c.id
   end
   @message = Message.find_by_id(msg_id)
     attachment = "attachment_" + params[:id]
   
    @message.update_attribute(attachment, nil)
    redirect_to :action => "detail",:id => msg_id
  end
  
end
