module Client::OrdersHelper
  def add_object_link(name, form, object, partial, where)
    html = render(:partial => partial, :locals => {:form => form}, :object => object)
    link_to_function name, %{
        var new_object_id = new Date().getTime() ;
        var html = jQuery(#{js html}.replace(/index_to_replace_with_js/g, new_object_id)).hide();
        html.appendTo(jQuery("#{where}")).slideDown('slow');
      }
  end

  def js(data)
    if data.respond_to? :to_json
      data.to_json
    else
      data.inspect.to_json
    end
  end

  def order_transction_types
    #types = ["Refinance", "Reverse Mortgage", "Purchase", "Sellers Package", "HELOC", "Grant Deed Only", "Application", "Power of Attorney", "Life Settlement", "Other"]
    types = ["Email", "Email 1&2", "Overnight", "Overnight 1&2", "ESIGN", "ESIGN 1&2", "Single", "Others"]
    types.collect { |t| [t, t] }.insert(0, ["Select one", ""])
  end

  def borrower1_work_phone(order)
    phone = ""
    if order.borrower_1_work_phone.length != 0
      phone << order.borrower_1_work_phone

      phone << %Q(<label for="borrower_1_work_phone_ext"> - Ext: </label>)
      if order.borrower_1_extension.length != 0
        phone << order.borrower_1_extension
      else
        phone << "Not Provided"
      end
    else
      phone << "Not Provided"
    end
    phone
  end

  def order_shipped_via
    shipped_via = @order.shipped_via
    if shipped_via && shipped_via.size > 0
      %Q(<p><label for="shipped_via">Shipped Via: </label> #{shipped_via}</p>)
    end
  end

  def order_tracking_number
    tracking_number = @order.tracking_number
    if tracking_number && tracking_number.size > 0
      %Q(<p><label for="tracking_number">Tracking Number: </label> #{tracking_number} </p>)
    end
  end

  def order_signing_date(order)
    signing_date = order.signing_date
    if signing_date > Date.today
      %Q(<p class="form_error">The Signing Date for the order you are completing is #{order.signing_date.strftime("%B %d, %Y")}, today is #{Date.today.strftime("%B %d, %Y")}. Please make sure you want to complete this order now.</p>)
    end
  #rescue
  #  ""
  end

  def client_order_table_data(obj, cur_tab)
     order_detail_libnk = "#"

     if request.url.include?('client/orders')
       order_detail_link = 'client/orders'
     else
       order_detail_link = 'notary/orders'
     end
     content_tag(:td, link_to(obj.id, :controller => order_detail_link, :action => 'order_detail', :order_id => obj.id, :tab => cur_tab)) +
     content_tag(:td, "#{obj.borrower_1_last_name.capitalize}, #{obj.borrower_1_first_name.capitalize}" )+
     content_tag(:td) do
       obj.read_attribute_before_type_cast("created_at").to_date.strftime('%m/%d/%Y')
     end +
     content_tag(:td) do
       obj.signing_date.strftime('%m/%d/%Y')+"&nbsp;&nbsp;"+obj.signing_time if obj.signing_date
     end +
     content_tag(:td) do
       obj.signing_location_city+", "+ obj.signing_location_state+"&nbsp;&nbsp;"+obj.signing_location_zip_code
     end +
     content_tag(:td) do
     if request.url.include?('client/orders')
       obj.notary.present? ? "#{obj.notary.first_name} #{obj.notary.last_name}" : "Not assigned"
     else
       obj.client.client_name
     end
     end +
     #~ content_tag(:td) do
       #~ if obj.client
        #~ %Q(
            #~ <a href="#" onClick="divwin=dhtmlwindow.open('divbox', 'div', 'client_info_#{obj.client.id}', '', 'width=380px,height=480px,left=200px,top=150px,resize=0,scrolling=0'); return false">#{obj.client.client_name}</a>
            #~ <div id="client_info_#{obj.client.id}" style="display:none;width: 100px;" class="span-18 last">
              #~ <h2 class="notary_info" style="margin-bottom:0px;">Client Details</h2>
              #~ <div class="span-8">
                #~ <ul class="notary_info">
                  #~ <p>
                  #~ <li><strong>Client ID:</strong> #{obj.client.id }</li>
                  #~ <li><strong>Company Name:</strong> #{obj.client.company_name }</li>
                  #~ <li><strong>Address:</strong> </li>
                  #~ <li>#{obj.client.address }<br/> #{obj.client.city }, #{obj.client.state } #{obj.client.zip_code}</li>
                  #~ <li><strong>Name:</strong> #{obj.client.client_name }</li>
                  #~ <li><strong>Title:</strong>#{
                      #~ if obj.client.title.length!=0
                        #~ obj.client.title
                      #~ else
                        #~ 'Not Provided'
                      #~ end
                    #~ }
                  #~ </li>
                  #~ </p>
                  #~ <p>
                  #~ <li><strong>Telephone:</strong>#{
                      #~ if obj.client.home_phone.length!=0
                        #~ obj.client.home_phone
                      #~ else
                        #~ 'Not Provided'
                      #~ end
                    #~ }
                  #~ </li>
                  #~ <li><strong>Mobile:</strong>#{
                        #~ if obj.client.mobile_phone.length!=0
                          #~ obj.client.mobile_phone
                        #~ else
                         #~ 'Not Provided'
                        #~ end
                      #~ }
                  #~ </li>
                  #~ <li><strong>Fax:</strong>#{
                    #~ if obj.client.fax_number.length!=0
                      #~ obj.client.fax_number
                    #~ else
                      #~ 'Not Provided'
                    #~ end
                    #~ }
                  #~ </li>
                  #~ </p>
                  #~ <p>
                  #~ <li><strong>Return Docs To:</strong></li>
                  #~ <li>#{obj.return_company_name }<br/> Attn: #{obj.return_attention} <br/> #{obj.return_address }<br/> #{obj.return_city},#{obj.return_state} #{obj.return_zip_code} <br/> #{obj.return_shipping_courier} Acct#: #{obj.return_account_number}</li>
                  #~ </p>
                #~ </ul>
              #~ </div>
            #~ </div>
          #~ )
       #~ end
     #~ end +
					content_tag(:td) do
					obj.attachments_count.nil? ? "--" : (obj.attachments_count > 0 ? image_tag("doc_icon.png") : '--')
					
					end
   end
end
