module Admin::ClientsHelper

  def client_order(client_id)
    @order=Order.find_all_by_client_id(client_id)

  end

  def client_order_id(client_id)
  @client_order_id=[]
  @order=Order.find_all_by_client_id(client_id)

  @order.each do |f|
    @client_order_id << f.id
    end
    return @client_order_id
  end


  def notary_list(order_id)
    @notary_list=[]
    notary_id=[]

      notary=MultipleNotary.find_all_by_order_id(order_id)
      if notary!=nil
      notary.each do|f|
         notary_id << f.notary_id
      end

      end
     if notary_id!=nil
            notary_id.each do |f|
        @notary_name=Notary.find_by_id(f)
        if @notary_name!=nil
        @notary_list<<@notary_name.first_name+" "+@notary_name.last_name
        end
      end
     end

    return @notary_list
  end

  def notary_list_id(order_id)
    @notary_list=[]
    notary_id=[]

      notary=MultipleNotary.find_all_by_order_id(order_id)
      if notary!=nil
      notary.each do|f|
         notary_id << f.notary_id
      end

      end


    return @notary_list
  end


  def requested_notary_size(order)
    @notary_list=[]
    order.each do |f|
      notary=MultipleNotary.find_all_by_order_id(f.id).size
        @notary_list << notary
    end

    return @notary_list.max
  end




def requested_date(order_id)
  @request_date=[]
 notary=MultipleNotary.find_all_by_order_id(order_id)

 if notary!=[]
   notary.each do |f|


  @request= f.read_attribute_before_type_cast("created_at").to_date.strftime '%m-%d-%Y'
  @request_date<<@request
   end
 else
   @request_date=nil
 end
 return @request_date
end

def signing_type(order_id)
  order=Order.find_by_id(order_id)
  if order.delivery_options=="Commercial Loan"
   @signing_type="Commercial"
  elsif order.delivery_options=="Email to Notary" || order.delivery_options=="Email to Borrower"
      @signing_type="Email"
  else
      @signing_type="Overnight"
  end
  return @signing_type
end

def no_of_doc(order_id)

  order=Order.find_by_id(order_id)
  if order.sets_of_docs==1
  @no_of_doc='1st'
  elsif order.sets_of_docs==2
   @no_of_doc="1st & 2nd"
   elsif order.sets_of_docs==3
   @no_of_doc="1st 2nd & 3rd"
   elsif order.sets_of_docs==4
   @no_of_doc="1st 2nd 3rd & 4th"
   elsif order.sets_of_docs==5
   @no_of_doc="1st 2nd 3rd 4th & 5th"
   elsif order.sets_of_docs==6
   @no_of_doc="1st 2nd 3rd 4th 5th & 6th"
  else
  end

  return @no_of_doc
end

def doc_notary_fee(orderid,notary_fee)
  order=Order.find_by_id(orderid)
  signing_type=signing_type(orderid)
  if signing_type=="Overnight"
    if order.sets_of_docs==1
      @fee=notary_fee
    else
      @fee=notary_fee+25
    end
  elsif signing_type=="Email"
    if order.sets_of_docs==1
      @fee=notary_fee+25
    else
      @fee=notary_fee+50
    end
  else
    @fee=notary_fee
  end
end




end
