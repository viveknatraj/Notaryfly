module Admin::NotariesHelper
  def notary_fee(notary_id)
    @notary = Notary.find_by_id(notary_id)

    fee = OrderFeedback.find_by_notary_id(@notary)
    @current_fee = 50
    if fee
      @overall_rating = []
      order = OrderFeedback.find_all_by_notary_id(@notary)
      order.each do |order1|
        @total_feedbacks = order1.accuracy.to_i + order1.communication.to_i + order1.punctuality.to_i + order1.professionalism.to_i + order1.fees.to_i
        @overall_rating << @total_feedbacks.to_f / 5
      end
      @rating_3_4 = @overall_rating.select { |i| i >= 3.00 and i<= 3.99 }.size

      @rating_4_5 = @overall_rating.select { |i| i >= 4.00 and i<= 5.00 }.size

      @notary_test = 'Not Completed'
      if fee.notaryflyu_test
        @current_fee = 75
        @notary_test = 'Completed'
      end
      if fee.notaryflyu_test
        if @rating_3_4 >= 100 and @rating_4_5 >= 50
          @current_fee = 85
        elsif @rating_3_4 >= 100 or @rating_4_5 >= 50
          @current_fee = 80
        end
        if @rating_3_4 >= 200 and @rating_4_5 >= 100
          @current_fee = 95
        elsif @rating_3_4 >= 200 or @rating_4_5 >= 100
          @current_fee = 90
        end
        if @rating_3_4 >= 300 and @rating_4_5 >= 150
          @current_fee = 105
        elsif @rating_3_4 >= 300 or @rating_4_5 >= 150
          @current_fee = 100
        end
        if @rating_3_4 >= 400 and @rating_4_5 >= 200
          @current_fee = 120
        elsif @rating_3_4 >= 400 or @rating_4_5 >= 200
          @current_fee = 115
        end
        if @rating_3_4 >= 500 or @rating_4_5 >= 250
          @current_fee = 125
        end
      else
        if @rating_3_4 >= 100 and @rating_4_5 >= 50
          @current_fee = 60
        elsif @rating_3_4 >= 100 or @rating_4_5 >= 50
          @current_fee = 55
        end
        if @rating_3_4 >= 200 and @rating_4_5 >= 100
          @current_fee = 70
        elsif @rating_3_4 >= 200 or @rating_4_5 >= 100
          @current_fee = 65
        end
        if @rating_3_4 >= 300 and @rating_4_5 >= 150
          @current_fee = 80
        elsif @rating_3_4 >= 300 or @rating_4_5 >= 150
          @current_fee = 75
        end
        if @rating_3_4 >= 400 and @rating_4_5 >= 200
          @current_fee = 90
        elsif @rating_3_4 >= 400 or @rating_4_5 >= 200
          @current_fee = 85
        end
        if @rating_3_4 >= 500 and @rating_4_5 >= 250
          @current_fee = 100
        elsif @rating_3_4 >= 500 or @rating_4_5 >= 250
          @current_fee = 95
        end
        if @rating_3_4 >= 600 and @rating_4_5 >= 300
          @current_fee = 110
        elsif @rating_3_4 >= 600 or @rating_4_5 >= 300
          @current_fee = 105
        end
        if @rating_3_4 >= 700 and @rating_4_5 >= 350
          @current_fee = 120
        elsif @rating_3_4 >= 700 or @rating_4_5 >= 350
          @current_fee = 115
        end
        if @rating_3_4 >= 800 or @rating_4_5 >= 400
          @current_fee = 125
        end
      end
    end
    if @notary_test==nil
      @notary_test='Not Completed'
    end
    if @rating_3_4==nil
      @rating_3_4=0
    end
    if @rating_4_5==nil
      @rating_4_5=0
    end


    return @notary_test, @rating_4_5, @current_fee, @rating_3_4
  end

  def notary_order(notary_id)
    @order=Order.find_all_by_notary_id(notary_id)

  end

  def notary_order_id(notary_id)
    @notary_order_id=[]
    @order=Order.find_all_by_notary_id(notary_id)
    @order.each do |f|
      @notary_order_id<<f.id
    end
    return @notary_order_id

  end

  def w9_content(notary)

    @notary=Notary.find_by_id(notary_id)
    file_data = @notary.w_9
    if file_data.respond_to?(:read)
      xml_contents = file_data.read
    elsif file_data.respond_to?(:path)
      xml_contents = File.read(file_data.path)
    else
      #logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end
    return xml_contents
  end

  def alert_notary_in_details
    notary = @notary
    accept_order = MultipleNotary.find_by_order_id_and_notary_id(params[:order_id], notary.id)
    if !accept_order.accept_status
      link_to_remote "OFFER NOTARY", {:url => { :controller => "admin/orders",:action=> "send_mail_to_notaries", :order_id => params[:order_id], :id => notary.id}}
    else
      link_to "NOTARY ASSIGNED", {}, :href => "javascript:void(0);"
    end
  rescue
    link_to_remote "OFFER NOTARY", {:url => { :controller => "admin/orders",:action=> "send_mail_to_notaries", :order_id => params[:order_id], :id => notary.id}}
  end

  def notary_completed_orders(notary)
    notary.orders.select { |order| order if order.status == "Completed" }.count
  end

  def notary_assinged_orders(notary)
    notary.orders.select { |order| order if order.status != "Completed" }.count
  end

  def state_list
    state = {"AL" => "Alabama",
     "AK" => "Alaska",
     "AZ" => "Arizona",
     "AR" => "Arkansas",
     "CA" => "California",
     "CO" => "Colorado",
     "CT" => "Connecticut",
     "DE" => "Delaware",
     "DC" => "District of Columbia",
     "FL" => "Florida",
     "GA" => "Georgia",
     "HI" => "Hawaii",
     "ID" => "Idaho",
     "IL" => "Illinois",
     "IN" => "Indiana",
     "IA" => "Iowa",
     "KS" => "Kansas",
     "KY" => "Kentucky",
     "LA" => "Louisiana",
     "ME" => "Maine",
     "MD" => "Maryland",
     "MA" => "Massachusetts",
     "MI" => "Michigan",
     "MN" => "Minnesota",
     "MS" => "Mississippi",
     "MO" => "Missouri",
     "MT" => "Montana",
     "NE" => "Nebraska",
     "NV" => "Nevada",
     "NH" => "New Hampshire",
     "NJ" => "New Jersey",
     "NM" => "New Mexico",
     "NY" => "New York",
     "NC" => "North Carolina",
     "ND" => "North Dakota",
     "OH" => "Ohio",
     "OK" => "Oklahoma",
     "OR" => "Oregon",
     "PA" => "Pennsylvania",
     "RI" => "Rhode Island",
     "SC" => "South Carolina",
     "SD" => "South Dakota",
     "TN" => "Tennessee",
     "TX" => "Texas",
     "UT" => "Utah",
     "VT" => "Vermont",
     "VA" => "Virginia",
     "WA" => "Washington",
     "WV" => "West Virginia",
     "WI" => "Wisconsin",
     "WY" => "Wyoming"}
    state.collect {|key, value| [value, key]}
  end
  
def notary_order_id(notary_id)
  @notary_order_id=[]
  @order=Order.find_all_by_notary_id(notary_id)
  @order.each do |f|
  @notary_order_id << f.id
  end
  return @notary_order_id
end

  def notary_order(notary_id)
    @order=Order.find_all_by_notary_id(notary_id)
  end

end
