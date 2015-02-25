# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include Client::OrdersHelper

  def time_dropdown
    [
    	["OPEN", "OPEN"],
    	["ASAP", "ASAP"],
    	["12:00PM", "12:00PM"],
    	["12:30PM", "12:30PM"], 
    	["01:00PM", "1:00PM"], 
    	["01:30PM", "1:30PM"], 
    	["02:00PM", "2:00PM"], 
    	["02:30PM", "2:30PM"], 
    	["03:00PM", "3:00PM"], 
    	["03:30PM", "3:30PM"], 
    	["04:00PM", "4:00PM"], 
    	["04:30PM", "4:30PM"], 
    	["05:00PM", "5:00PM"], 
    	["05:30PM", "5:30PM"], 
    	["06:00PM", "6:00PM"], 
    	["06:30PM", "6:30PM"], 
    	["07:00PM", "7:00PM"], 
    	["07:30PM", "7:30PM"], 
    	["08:00PM", "8:00PM"], 
    	["08:30PM", "8:30PM"], 
    	["09:00PM", "9:00PM"], 
    	["09:30PM", "9:30PM"], 
    	["10:00PM", "10:00PM"], 
    	["10:30PM", "10:30PM"], 
    	["11:00PM", "11:00PM"], 
    	["11:30PM", "11:30PM"], 
    	["12:00AM", "12:00AM"],
    	["12:30AM", "12:30AM"], 
    	["01:00AM", "1:00AM"], 
    	["01:30AM", "1:30AM"], 
    	["02:00AM", "2:00AM"], 
    	["02:30AM", "2:30AM"], 
    	["03:00AM", "3:00AM"], 
    	["03:30AM", "3:30AM"], 
    	["04:00AM", "4:00AM"], 
    	["04:30AM", "4:30AM"], 
    	["05:00AM", "5:00AM"], 
    	["05:30AM", "5:30AM"], 
    	["06:00AM", "6:00AM"], 
    	["06:30AM", "6:30AM"], 
    	["07:00AM", "7:00AM"], 
    	["07:30AM", "7:30AM"], 
    	["08:00AM", "8:00AM"], 
    	["08:30AM", "8:30AM"], 
    	["09:00AM", "9:00AM"], 
    	["09:30AM", "9:30AM"], 
    	["10:00AM", "10:00AM"], 
    	["10:30AM", "10:30AM"], 
    	["11:00AM", "11:00AM"], 
    	["11:30AM", "11:30AM"],
    ]
  end
  def statename(code)
    case code
    when "AL"
      code="Alabama"    
    when "AK"
      code="Alaska"
    when "AZ"
      code="Arizona"
    when "AR"
      code="Arkansas"
    when "CA"
      code="California"
    when "CO"
      code="Colorado"
    when "CT"
      code="Connecticut"
    when "DE"
      code="Delaware"
    when "DC"
      code="District of Columbia"
    when "FL"
      code="Florida"
    when "GA"
      code="Georgia"
    when "HI"
      code="Hawaii"
    when "ID"
      code="Idaho"
    when "IL"
      code="Illinois"
    when "IN"
      code="Indiana"
    when "IA"
      code="Iowa"
    when "KS"
      code="Kansas"
    when "KY"
      code="Kentucky"
    when "LA"
      code="Louisiana"
    when "ME"
      code="Maine"
    when "MD"
      code="Maryland"
    when "MA"
      code="Massachusetts"
    when "MI"
      code="Michigan"
    when "MN"
      code="Minnesota"
    when "MS"
      code="Mississippi"
    when "MO"
      code="Missouri"
    when "MT"
      code="Montana"
    when "NE"
      code="Nebraska"
    when "NV"
      code="Nevada"
    when "NH"
      code="New Hampshire"
    when "NJ"
      code="New Jersey"
    when "NM"
      code="New Mexico"
    when "NY"
      code="New York"
    when "NC"
      code="North Carolina"
    when "ND"
      code="North Dakota"
    when "OH"
      code="Ohio"
    when "OK"
      code="Oklahoma"
    when "OR"
      code="Oregon"
    when "PA"
      code="Pennsylvania"
    when "RI"
      code="Rhode Island"
    when "SC"
      code="South Carolina"
    when "SD"
      code="South Dakota"
    when "TN"
      code="Tennessee"
    when "TX"
      code="Texas"
    when "UT"
      code="Utah"
    when "VT"
      code="Vermont"
    when "VA"
      code="Virginia"
    when "WA"
      code="Washington"
    when "WV"
      code="West Virginia"
    when "WI"
      code="Wisconsin"
    when "WY"
      code="Wyoming"
    else
      code="N/A"
    end        
  end  
end

