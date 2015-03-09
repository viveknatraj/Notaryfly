class Admin::ClientsController < ApplicationController
layout "adminpanel"

  def edit_customer_fee
    @clients=Client.find(params[:client_id])
    @clients.update_attribute(:customer_fee, params[:customer_fee])
    redirect_to :back
  end
  def index
		if params[:msg].present?			
						@notice_msg=params[:msg]
		end
    if session[:admin_user] == nil
      redirect_to session[:url]
    end

    if params[:order]!=nil
           @order = "clients."+params[:sortby]+" "+params[:order]
    else
      @order = "clients.id ASC"
    end
    if params[:keyword]!=nil
        @clients = Client.paginate :page => params[:page], :joins => "INNER JOIN users ON users.id = clients.user_id",:conditions=>["user_type='client' AND client_name like ?",'%'+params[:keyword]+'%'], :order => @order
    else
        @clients = Client.paginate :page => params[:page], :joins => "INNER JOIN users ON users.id = clients.user_id",:conditions=>["user_type='client'"], :order => @order
    end
  end

  def send_message
    if session[:admin_user] == nil
      redirect_to session[:url]
    end

    client_ids =  params[:clients]['ids']
    
    if client_ids!=nil and client_ids.length!=0

      @split_ids = client_ids.split(",")
      tot_ids =  @split_ids.size
      i = 0

      tot_ids.times do

      @clients = Client.find_by_user_id(@split_ids[i])
      @client_mail = User.find_by_id(@split_ids[i])
      @message = Message.new
      @message.recipient_id = @split_ids[i]
      @message.title = params[:title]["title"]
      @message.body = params[:notes]["notes"]
      @message.is_unread = true
      @message.save

      Notifier.deliver_admin_message(@clients.client_name,@client_mail.email, @client_mail.user_password)

      i += 1

      end


    end
   

      redirect_to :action => 'index'
  end


    def promocode

      if request.post?
        Promocode.update(1,:promocode=> params[:promo]['promo'],:credits=> params[:credits]['credits'])
      end
      @promocode = Promocode.find_by_id(1)
  end


    def settings
            if request.post?
        Admin.update(1,:username=> params[:admin]['username'],:password=> params[:admin]['password'])
      end
      @admin = Admin.find_by_id(1)
    end

    def add_credits
      user_id = params[:client]['user_id'].to_s
      credit = Credit.find_by_user_id(user_id)
      credit.update_attributes(:credits=>credit.credits+1,:total_credits=>credit.total_credits+1)
      redirect_to :action => 'index'
    end

   def destroy
    @client = Client.find_by_id(params[:id])
    User.delete(@client.user_id)
    Order.delete_all("client_id = #{params[:id]}")
    OrderFeedback.delete_all("client_id = #{params[:id]}")
    Message.delete_all("user_id = #{@client.user_id} OR recipient_id = #{@client.user_id}")
    Agent.delete_all("client_id = #{params[:id]}")
    Credit.delete_all("user_id = #{@client.user_id}")
    Invoice.delete_all("client_id = #{@client.user_id}")
    Client.delete(params[:id])
    redirect_to :action => 'index'
  end

   def suspend_update
    @user=User.find_by_id(params[:id])
    
    if @user.suspend == 'nil' || @user.suspend == 1
      @user.update_attribute("suspend",0)
    else
      @user.update_attribute("suspend",1)
    end
  end
  
	 # New action to render assign executive page
	def assign_executive
					# getting associated client
					@client=Client.find(params[:client_id])
					# getting the client executives mapping details
					@client_executive=@client.client_executives.present? ? @client.client_executives.first : nil
					params[:client]={} if params[:client].blank?
					# rendering the view
					render :assign_executive
	end

	# update executive action to update the client executive mappings in database
	def update_executive
					# removing blank strings
					params[:client][:executives].reject! {|e| e.blank? }
					flash[:errors]=[]
					@client=Client.find(params[:client][:id])
					# validating parameters
					if params[:client][:executives].blank?
									flash[:errors].push("Please select atleast one executive")
					end
					# restrict user to map maximum of 3 executives for a client
					if params[:client][:executives].count > 3
									flash[:errors].push("Only maximum of 3 executives can be mapped")
					end
					if params[:client][:percentage].blank? and params[:client][:amount].blank?
									flash[:errors].push("Please provide either static amount or amount percentage")
					end
					if params[:client][:percentage].present? and !params[:client][:percentage].match(/[0-9.]+/)
									flash[:errors].push("Share percentage should be numeric or float")
					end
					if params[:client][:percentage].present? and params[:client][:percentage].to_i > 100
									flash[:errors].push("Share percentage should be within 100")
					end
					if params[:client][:amount].present? and !params[:client][:amount].match(/[0-9]+/)
									flash[:errors].push("Static amount should be numeric")
					end
					if flash[:errors].present?
									render :assign_executive
					else
									count=0
									# removing all old client executive records for client
									if @client.client_executives.present? and params[:client][:executives].map(&:to_i)!=@client.client_executives.map(&:executive_id)
													@client.client_executives.delete_all
													# need to create new client executive records in database by mapping executive and client
													params[:client][:executives].each{|e|
																	ce=ClientExecutive.create(:client_id => @client.id, :executive_id => e, :share_percentage => params[:client][:percentage], :share_value => params[:client][:amount])
																	count+=1
													}
													msg="#{count} executive(s) mapped to '#{@client.company_name}' client"
									elsif @client.client_executives.present? and params[:client][:executives].map(&:to_i)==@client.client_executives.map(&:executive_id)
													@client.client_executives.each{|ce| 
																	ce.update_attributes(:share_percentage => params[:client][:percentage], :share_value => params[:client][:amount])
													}
													msg="#{@client.client_executives.count} executive(s) details are updated"
									elsif @client.client_executives.empty? and params[:client][:executives].present?
													# need to create new client executive records in database by mapping executive and client
													params[:client][:executives].each{|e|
																	ce=ClientExecutive.create(:client_id => @client.id, :executive_id => e, :share_percentage => params[:client][:percentage], :share_value => params[:client][:amount])
																	count+=1
													}
													msg="#{count} executive(s) mapped to '#{@client.company_name}' client"
									end
									redirect_to :action => 'index', :msg => msg
					end
	end
end
