class HomeController < ApplicationController
  include GeoKit::Geocoders
    include SslRequirement
    ssl_required  :buy_credits

  def zip_code_search
    if params[:zip_code]!=nil and params[:zip_code].length!=0
    @geo=GeoKit::Geocoders::MultiGeocoder.geocode(params[:zip_code])   
    @notaries="" if !@geo.success
      @notaries = Notary.find(:all, :origin => params[:zip_code], :within=> 20 ) if @geo.success
   else
      @notaries=""
    end
  end
end
