class Admin::ExecutivesController < ApplicationController
layout "adminpanel"
  def index
    if session[:admin_user] == nil
      redirect_to session[:url]
    end
    if params[:keyword]!=nil
      @executives = Executive.paginate :page => params[:page], :order => 'id ASC',:conditions=>["name like ? or address like ? or city like ? or state like ?",'%'+params[:keyword]+'%','%'+params[:keyword]+'%','%'+params[:keyword]+'%','%'+params[:keyword]+'%']
    else
      @executives = Executive.paginate :page => params[:page], :order => 'id ASC'
    end
  end
	def new
					@executive=Executive.new
	end
  def edit
    @executive = Executive.find(params[:id])
  end

	def create
					@executive=Executive.create(params[:executive])
					if @executive.save
									redirect_to :action => 'index'
					else
									flash[:errors]=@executive.errors.full_messages
									render :new
					end
	end

	def update
					@executive=Executive.find(params[:id])
    			if @executive.update_attributes(params[:executive])
									redirect_to :action => 'index'
					else
									flash[:errors]=@executive.errors.full_messages
									render :edit
					end
	end
end
