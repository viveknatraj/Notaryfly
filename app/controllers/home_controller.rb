class HomeController < ApplicationController
  include GeoKit::Geocoders
    include SslRequirement
    ssl_required  :buy_credits

  def zip_code_search
    flash[:notaries] = {:success => false, :count => 0, :zip_code => params[:zip_code]}
    if params[:zip_code]!=nil and params[:zip_code].length!=0
      @geo=GeoKit::Geocoders::MultiGeocoder.geocode(params[:zip_code])   
      if flash[:notaries][:success] = @geo.success
        flash[:notaries][:count] = Notary.find(:all, :origin => params[:zip_code], :within=> 20 ).count
      end
    end
    redirect_to :action => 'index'
  end
end
