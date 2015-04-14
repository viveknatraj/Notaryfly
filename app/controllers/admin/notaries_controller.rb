class Admin::NotariesController < ApplicationController
  layout "adminpanel"

  def index
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    if params[:keyword]!=nil
      @notaries = Notary.paginate :page => params[:page], :joins => "INNER JOIN users ON users.id = notaries.user_id", :order => 'last_name ASC', :conditions => ["(on_vacation = 0 or on_vacation is null) AND user_type='notary' AND last_name like ? ", '%'+params[:keyword]+'%']
    else
      @notaries = Notary.paginate :page => params[:page], :joins => "INNER JOIN users ON users.id = notaries.user_id", :order => 'last_name ASC', :conditions => ["user_type='notary'"]
    end
    @feedback_average_final=[]

    @notaries.each do |f|
      @feedback=OrderFeedback.find_all_by_notary_id(f.id)
      @feedback_count=OrderFeedback.find_all_by_notary_id(f.id).count
      @feedback_average=[]
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
      @feedback_average_final<<@feedback_average.sum/ @feedback_count
    end
#raise @feedback_average_final.inspect
  end

  def send_message
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    client_ids = params[:clients]['ids']
    if client_ids!=nil and client_ids.length!=0
      @split_ids = client_ids.split(",")
      tot_ids = @split_ids.size
      i = 0

      tot_ids.times do
        @message = Message.new
        @message.recipient_id = @split_ids[i]
        @message.title = params[:title]["title"]
        @message.body = params[:notes]["notes"]
        @message.is_unread = true
        @message.save

        @notaries = Notary.find_by_user_id(@split_ids[i])
        @client_mail = User.find_by_id(@split_ids[i])
        @notary_name = @notaries.first_name+" "+@notaries.last_name
        Notifier.deliver_admin_message(@notary_name, @client_mail.email, @client_mail.user_password)

        i += 1

      end
    end
    redirect_to :action => 'index'
  end

  def destroy
    @notary = Notary.find_by_id(params[:id])
    User.delete(@notary.user_id)
    Order.delete_all("notary_id = #{params[:id]}")
    OrderFeedback.delete_all("notary_id = #{params[:id]}")
    Message.delete_all("user_id = #{@notary.user_id} OR recipient_id = #{@notary.user_id}")
    Notary.delete(params[:id])
    redirect_to :action => 'index', :page => params[:page]
  end

  def vacation_update
    @notary = Notary.find_by_id(params[:id])
    if @notary.on_vacation == true
      @notary.update_attribute("on_vacation", false)
    else
      @notary.update_attribute("on_vacation", true)
    end

  end

  def suspend_update
    @user=User.find_by_id(params[:id])

    if @user.suspend == 'nil' || @user.suspend == 1
      @user.update_attribute("suspend", 0)
    else
      @user.update_attribute("suspend", 1)
    end
  end

  def notary_fee

  end


  def send_file
    file_path = "#{Rails.root}/public/#{params[:filename]}"
    send_file file_path, :filename => params[:filename], :disposition => 'attachment'
  end

  def notary_details
    @notary = Notary.find(params[:id])
    @order_feedback = OrderFeedback.find_all_by_notary_id(params[:id])
    count = @order_feedback.count
    @star_rating = 0.0
    if !@order_feedback.empty?
      accuracy        = (@order_feedback.map(&:accuracy).sum/count).to_f rescue 0.to_f
      communication   = (@order_feedback.map(&:communication).sum/count).to_f rescue 0.to_f
      punctuality     = (@order_feedback.map(&:punctuality).sum/count).to_f rescue 0.to_f
      fees            = (@order_feedback.map(&:fees).sum/count).to_f rescue 0.to_f
      professionalism = (@order_feedback.map(&:professionalism).sum/count).to_f rescue 0.to_f
      @star_rating = [accuracy, communication, punctuality, fees, professionalism].sum/5 rescue 0.to_f
    end

    if request.xhr?
      respond_to do |format|
        format.js
      end
    else
      if params[:notary]
        #fee = params[:notary][:fee_type] == "Base Fee" ? params[:notaries][:base_fee] : params[:notaries][:override_fee]
        fee = params[:notaries][:base_fee]
        if @notary.update_attributes(params[:notary].merge!(:fee => fee.to_i))
          flash[:notice] = "Notary details are updated"
        else
          flash[:error] = "Notary details are not updated<br/>\n#{@notary.errors.full_messages.join('<br>')}"
        end
      end
      redirect_to :controller => "admin/orders", :action => :find_notary, :id => params[:order_id], :order => params[:order], :notary_search => params[:notary_search], :page => params[:page]
    end
  end

  def assign_notary
    @order = Order.find(params[:order_id])
    @order.update_attributes(:notary_id => params[:notary_id], :status => "order accepted")

    @multiple_notary = MultipleNotary.find_by_order_id(params[:order_id])
    if @multiple_notary
      @multiple_notary.update_attributes(:notary_id => params[:notary_id], :accept_status => true)
    else
      @multiple_notary = MultipleNotary.create(:order_id => params[:order_id], :notary_id => params[:notary_id], :status => "order accepted", :accept_status => true)
    end

    flash[:notice] = "Notary assinged"
    #respond_to do |format|
    #  format.js
    #end
    #redirect_to({:action => :find_notary}.merge!(params))
    render :update do |page|
      #page.hide '#notary_assigned-msg'
      page.replace_html '#notary_assigned-msg', "Notary assinged successfully"
      #page.show '#notary_assigned-msg'
    end
  end

end
