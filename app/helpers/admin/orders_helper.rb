module Admin::OrdersHelper
								
								def notary_list(order_id)
																@notary_list=[]
																notary_id=[]
																
																notary=MultipleNotary.find_all_by_order_id(order_id)
																if notary!=nil
																								notary.each do |f|
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
								
								
								def requested_notary_size(order)
																@notary_list=[]
																order.each do |f|
																notary=MultipleNotary.find_all_by_order_id(f.id).size
																@notary_list << notary
																end
																return @notary_list.sum
								end
								
								def requested_date(order_id)
																
																notary=MultipleNotary.find_by_order_id(order_id)
																
																if notary!=nil
																								@request_date= notary.created_at.strftime('%d-%m-%y')
																else
																								@request_date=nil
																end
																return @request_date
								end
								
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
								
								def within_miles
																miles = ["10", "25", "50", "75", "100"]
																miles.collect { |m| [m, m] }
								end
								
								def notary_orders(notary)
																notary.orders.count
								rescue
																0
								end
								
								def notary_star_rating(notary)
																@order_feedback = OrderFeedback.find_all_by_notary_id(notary.id)
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
																@star_rating
								end
								
								def notary_distance(notary)
																if notary.distance.present?
																								"#{sprintf("%.02f",notary.distance)} miles"
																end
								end
								
								def notary_city_state(notary)
																city = (notary.weekday_deliver_city.present? && notary.weekday_deliver_city) || ""
																state = (notary.weekday_deliver_state.present? && notary.weekday_deliver_state) || ""
																#zip_code = (notary.weekday_deliver_zip_code.present? && notary.weekday_deliver_zip_code) || ""
																#"#{city}, #{state} #{zip_code}".gsub(/^\s*,\s*$/,'')
																"#{city}, #{state}".gsub(/^\s*,\s*$/,'')
								end
								
								def notary_phone(notary)
																phone = notary.mobile_phone
																if phone.present?
																								"#{phone}"
																end
								end
								
								def alert_notary(notary)
																accept_order = MultipleNotary.find_by_order_id_and_notary_id(params[:id],notary.id)
																if !accept_order.accept_status
																								link_to_remote (image_tag "alert_notary-1.png"),
																								:url => {:controller => "admin/orders",
																																	:action=> "send_mail_to_notaries",
																																	:mile => notary.distance,
																																	:order_id => params[:id], :id => notary.id},
																								:loading => "$('#load_msg').css('color', 'red').html('Pleaes Wait....').show();",
																																:complete => "$('#load_msg').css('color', 'green').html('Notary Alert Message Successfully Sent');$('#initial_count_#{notary.id}').hide();"
																else
																								image_tag 'notary-assigned.png'
																end
								rescue
																link_to_remote (image_tag "alert_notary-1.png"),
																:url => {:controller => "admin/orders",
																									:action=> "send_mail_to_notaries",
																									:mile => notary.distance,
																									:order_id => params[:id], :id => notary.id},
																:loading => "$('#load_msg').css('color', 'red').html('Pleaes Wait....').show();",
																:complete => "$('#load_msg').css('color', 'green').html('Notary Alert Message Successfully Sent');"
								end

								def completed_orders
																link_to_remote ("COMPLETED ORDERS"),
																								:url => {:controller => "admin/orders",
																																	:action=> "index"},
																																	:loading => "$('#ajax-loader').css('display', 'block');",
																																	:complete => "$('#ajax-loader').css('display', 'none');"
								end

								def accounting_tab
																link_to_remote ("ACCOUNTING"),
																								:url => {:controller => "admin/orders",
																																	:action=> "accounting"},
																																	:loading => "$('#ajax-loader').css('display', 'block');",
																																	:complete => "$('#ajax-loader').css('display', 'none');"
								end

								def cancelled_orders
																link_to_remote ("CANCELLED ORDERS"),
																								:url => {:controller => "admin/orders",
																																	:action=> "order_history_cancelled"},
																																	:loading => "$('#ajax-loader').css('display', 'block');",
																																	:complete => "$('#ajax-loader').css('display', 'none');"
								end

								def paid_in_full
																link_to_remote ("PAID IN FULL"),
																								:url => {:controller => "admin/orders",
																																	:action=> "order_history_paid"},
																																	:loading => "$('#ajax-loader').css('display', 'block');",
																																	:complete => "$('#ajax-loader').css('display', 'none');"
								end

								def order_history_accounting
																link_to_remote ("ACCOUNTING"),
																								:url => {:controller => "admin/orders",
																																	:action=> "order_history_accounting"},
																																	:loading => "$('#ajax-loader').css('display', 'block');",
																																	:complete => "$('#ajax-loader').css('display', 'none');"
								end





								
								def order_notary_email(order)
																order.notary.user.email
								rescue
																""
								end


								
								
								def order_status_class(order)
																if order.status == "need notary"
																								"light-blue"
																elsif (order.status_timeline == "Notary Assigned" && order.status == "filled")
																								"mid-light-blue"
																elsif order.status_timeline == "Time/Date Signing Set" && order.status != "Refuse To Sign"
																								"dark-blue"
																elsif order.status != "Refuse To Sign" && order.status_timeline == "Documents Received by Notary"
																								"light-green"
																elsif order.status == "Refuse To Sign"
																								"mid-light-green"
																elsif ["signing_completed", "Signing Completed"].include?(order.status_timeline)
																								"dark-light-green"
																elsif ["notary_paid_full", "Notary Paid in Full"].include?(order.status_timeline)
																								"high-dark-light-green"
																else
																								"white-bg"
																end
								end
								
								def admin_order_table_data(obj, cur_tab)
																order_detail_libnk = "#"
																
																order_detail_link = 'admin/orders'
																
																content_tag(:td, link_to(obj.id, :controller => order_detail_link, :action => 'order_detail', :order_id => obj.id, :tab => cur_tab)) +
																content_tag(:td, "#{obj.borrower_1_last_name}&nbsp;#{obj.borrower_1_first_name}" )+
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
																if obj.client
																								%Q(
												<a href="#" onClick="divwin=dhtmlwindow.open('divbox', 'div', 'client_info_#{obj.client.id}', '', 'width=380px,height=480px,left=200px,top=150px,resize=0,scrolling=0'); return false">#{obj.client.client_name}</a>
												<div id="client_info_#{obj.client.id}" style="display:none;width: 100px;" class="span-18 last">
														<h2 class="notary_info" style="margin-bottom:0px;">Client Details</h2>
														<div class="span-8">
																<ul class="notary_info">
																		<p>
																		<li><strong>Client ID:</strong> #{obj.client.id }</li>
																		<li><strong>Company Name:</strong> #{obj.client.company_name }</li>
																		<li><strong>Address:</strong> </li>
																		<li>#{obj.client.address }<br/> #{obj.client.city }, #{obj.client.state } #{obj.client.zip_code}</li>
																		<li><strong>Name:</strong> #{obj.client.client_name }</li>
																		<li><strong>Title:</strong>#{
																								if obj.client.title.length!=0
																																obj.client.title
																								else
																																'Not Provided'
																								end
																								}
																		</li>
																		</p>
																		<p>
																		<li><strong>Telephone:</strong>#{
																								if obj.client.home_phone.length!=0
																																obj.client.home_phone
																								else
																																'Not Provided'
																								end
																								}
																		</li>
																		<li><strong>Mobile:</strong>#{
																								if obj.client.mobile_phone.length!=0
																																obj.client.mobile_phone
																								else
																																'Not Provided'
																								end
																								}
																		</li>
																		<li><strong>Fax:</strong>#{
																								if obj.client.fax_number.length!=0
																																obj.client.fax_number
																								else
																																'Not Provided'
																								end
																								}
																		</li>
																		</p>
																		<p>
																		<li><strong>Return Docs To:</strong></li>
																		<li>#{obj.return_company_name }<br/> Attn: #{obj.return_attention} <br/> #{obj.return_address }<br/> #{obj.return_city},#{obj.return_state} #{obj.return_zip_code} <br/> #{obj.return_shipping_courier} Acct#: #{obj.return_account_number}</li>
																		</p>
																</ul>
														</div>
												</div>
																								)
																end
																end +
																if cur_tab == 'tabs8'
																								content_tag(:td, link_to("Move to paid orders", :controller => order_detail_link, :action => 'move_to_paid', :order_id => obj.id, :tab => cur_tab)) 
																else
																								content_tag(:td) do
																								obj.attachments_count.nil? ? "--" : (obj.attachments_count > 0 ? image_tag("doc_icon.png") : '--')
																								end
																end
								end

								def admin_order_table_data_new(obj, cur_tab)
																order_detail_libnk = "#"

																order_detail_link = 'admin/orders'

																content_tag(:td, link_to(obj.id, :controller => order_detail_link, :action => 'order_detail', :order_id => obj.id, :tab => cur_tab)) +
																								content_tag(:td, "#{obj.borrower_1_last_name}&nbsp;#{obj.borrower_1_first_name}" )+
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
																																if obj.client
																																								%Q(
												<a href="#" onClick="divwin=dhtmlwindow.open('divbox', 'div', 'client_info_#{obj.client.id}', '', 'width=380px,height=480px,left=200px,top=150px,resize=0,scrolling=0'); return false">#{obj.client.client_name}</a>
												<div id="client_info_#{obj.client.id}" style="display:none;width: 100px;" class="span-18 last">
														<h2 class="notary_info" style="margin-bottom:0px;">Client Details</h2>
														<div class="span-8">
																<ul class="notary_info">
																		<p>
																		<li><strong>Client ID:</strong> #{obj.client.id }</li>
																		<li><strong>Company Name:</strong> #{obj.client.company_name }</li>
																		<li><strong>Address:</strong> </li>
																		<li>#{obj.client.address }<br/> #{obj.client.city }, #{obj.client.state } #{obj.client.zip_code}</li>
																		<li><strong>Name:</strong> #{obj.client.client_name }</li>
																		<li><strong>Title:</strong>#{
																										if obj.client.title.length!=0
																																		obj.client.title
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		</p>
																		<p>
																		<li><strong>Telephone:</strong>#{
																										if obj.client.home_phone.length!=0
																																		obj.client.home_phone
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		<li><strong>Mobile:</strong>#{
																										if obj.client.mobile_phone.length!=0
																																		obj.client.mobile_phone
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		<li><strong>Fax:</strong>#{
																										if obj.client.fax_number.length!=0
																																		obj.client.fax_number
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		</p>
																		<p>
																		<li><strong>Return Docs To:</strong></li>
																		<li>#{obj.return_company_name }<br/> Attn: #{obj.return_attention} <br/> #{obj.return_address }<br/> #{obj.return_city},#{obj.return_state} #{obj.return_zip_code} <br/> #{obj.return_shipping_courier} Acct#: #{obj.return_account_number}</li>
																		</p>
																</ul>
														</div>
												</div>
																		)
																																end
																								end +
																								content_tag(:td, link_to("Move to order history", :controller => order_detail_link, :action => 'order_update', :order_id => obj.id, :tab => cur_tab)) 
								end

								def admin_order_table_data_order_history(obj, cur_tab)
																order_detail_libnk = "#"

																order_detail_link = 'admin/orders'

																content_tag(:td, link_to(obj.id, :controller => order_detail_link, :action => 'order_detail', :order_id => obj.id, :tab => cur_tab)) +
																								content_tag(:td, "#{obj.borrower_1_last_name}&nbsp;#{obj.borrower_1_first_name}" )+
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
																																if obj.client
																																								%Q(
												<a href="#" onClick="divwin=dhtmlwindow.open('divbox', 'div', 'client_info_#{obj.client.id}', '', 'width=380px,height=480px,left=200px,top=150px,resize=0,scrolling=0'); return false">#{obj.client.client_name}</a>
												<div id="client_info_#{obj.client.id}" style="display:none;width: 100px;" class="span-18 last">
														<h2 class="notary_info" style="margin-bottom:0px;">Client Details</h2>
														<div class="span-8">
																<ul class="notary_info">
																		<p>
																		<li><strong>Client ID:</strong> #{obj.client.id }</li>
																		<li><strong>Company Name:</strong> #{obj.client.company_name }</li>
																		<li><strong>Address:</strong> </li>
																		<li>#{obj.client.address }<br/> #{obj.client.city }, #{obj.client.state } #{obj.client.zip_code}</li>
																		<li><strong>Name:</strong> #{obj.client.client_name }</li>
																		<li><strong>Title:</strong>#{
																										if obj.client.title.length!=0
																																		obj.client.title
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		</p>
																		<p>
																		<li><strong>Telephone:</strong>#{
																										if obj.client.home_phone.length!=0
																																		obj.client.home_phone
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		<li><strong>Mobile:</strong>#{
																										if obj.client.mobile_phone.length!=0
																																		obj.client.mobile_phone
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		<li><strong>Fax:</strong>#{
																										if obj.client.fax_number.length!=0
																																		obj.client.fax_number
																										else
																																		'Not Provided'
																										end
																		}
																		</li>
																		</p>
																		<p>
																		<li><strong>Return Docs To:</strong></li>
																		<li>#{obj.return_company_name }<br/> Attn: #{obj.return_attention} <br/> #{obj.return_address }<br/> #{obj.return_city},#{obj.return_state} #{obj.return_zip_code} <br/> #{obj.return_shipping_courier} Acct#: #{obj.return_account_number}</li>
																		</p>
																</ul>
														</div>
												</div>
																		)
																																end
																								end +
																								content_tag(:td) do
																																obj.attachments_count.nil? ? "--" : (obj.attachments_count > 0 ? image_tag("doc_icon.png") : '--')
																								end
								end
								def open_order_details_first_tab
																if (@order.status != "need notary") && (@order.status_timeline == "Notary Assigned" || @order.status_timeline == "Time/Date Signing Set" || @order.status_timeline == "Documents Received by Notary" || @order.status_timeline == "Signing Completed" || @order.status_timeline == 'Notary Paid in Full' || @order.status == 'Refuse to Sign' || @order.status_timeline == 'Order Completed')
																								"active-first"
																else
																								"active-not"
																end
								end
								
								def order_notary_fee
																@notary.fee rescue ""
								end
								
								def orders_upload_docs(num, form)
																f = form
																attachments_count = 6
																if @order["order_attachment_#{num}_file_name"]
																								html = %Q(<p id="order[order_attachment_#{num}]" style="padding:7px; 0;clear:both;">)
																								html << %Q(<span style="float:left;width:350px;">)
																								html << @order["order_attachment_#{num}_file_name"]
																								html << "</span>"
																								
																								html << %Q(<span style="float:left;width:250px;text-align:right">)
																								html << link_to("(view)", @order.order_attachment_1.url, :target => "blank")
																								html << " "
																								html << link_to("(delete)", :action => "delete_attachment", :id => "#{num}_"+@order.id.to_s, :redirect_to => request.url)
																								html << " "
																								html << " (#{num} of #{attachments_count})"
																								html << "</span>"
																else
																								#html = %Q(<p id="order[order_attachment_#{num}]" style="padding:7px; 0;clear:both;">)
																								#html << %Q(<span style="float:left;width:350px;">)
																								#html << "Add : "
																								#html << f.file_field(:"order_attachment_#{num}")
																								#html << "</span>"
																								#html << %Q(<span style="float:left;width:250px;text-align:right">)
																								#html << link_to("(delete)", {}, :href => "javascript:void(0)", :onclick => "javascript:removeFile('order[order_attachment_#{num}]','#{num}'); return false;")
																								#html << " "
																								#html << " (#{num} of #{attachments_count})"
																								#html << "</span>"
																								#html << "</p>"
																end
								end
								
								def orders_upload_docs_count(num)
																@order["order_attachment_#{num}_file_name"]
								end
								
end



