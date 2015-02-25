class Client::BrokersController < ApplicationController
  include SslRequirement
  ssl_required  :buy_credits
  before_filter :credits
  
  def new
    @client = Client.find_by_user_id(self.current_user.id)
    @my_agents = Agent.find(:all, :conditions => ["client_id = ?", @client.id])
    @agent = Agent.new
    @agent_count = Agent.find(:all, :conditions => ["client_id = ?", @client.id])
  end
  
  def create
    @agent = Agent.new(params[:agent])
    @client = Client.find_by_user_id(self.current_user.id)
    @agent.client_id = @client.id
    
    if @agent.save
      redirect_to(:action => 'new')
    end
  end
  
  def edit
    @client = Client.find_by_user_id(self.current_user.id)    
    if params[:id] 
      @agent = Agent.find(params[:id])
    else
      @agent = Agent.find(params[:agent][:id])
    end
  end
  
  def update
     @agent = Agent.find(params[:id])
     if @agent.update_attributes(params[:agent])
       flash[:notice] = "Agent information updated"
       redirect_to :action => "edit", :id => @agent.id
     end
  end
  
  def destroy
    @agent = Agent.find_by_id(params[:id])
    
    if @agent
    @agent.destroy
    end

    redirect_to :action => "new"
  end
end
