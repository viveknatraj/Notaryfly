pdf.stroke_rectangle [0,635], 250, 270
pdf.stroke_rectangle [300,635], 250, 270


pdf.stroke_rectangle [0,335], 250, 85
pdf.stroke_rectangle [300,335], 250, 85

pdf.stroke_rectangle [0,230], 550, 172

pdf.text "NotaryFLY.com", :at => [0,720], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,720], :size => 17, :style => :bold
pdf.move_down(30)


pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "      NF Order # ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text ": #{@order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow # "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text ": #{@order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text ": #{@order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text ": #{@order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{@order.client.address}" , :size => 8, :at =>[75,576]
pdf.text "    #{@order.client.city} , #{@order.client.state} #{@order.client.zip_code}" , :size => 8, :at =>[75,568]
pdf.text "  Contact Name  " , :size => 9, :style => :bold, :at =>[10,556]

if @order.client.client_name.size!=0
pdf.text "  : #{@order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #  ", :size => 9, :style => :bold, :at =>[10,544]

if @order.client.home_phone.size!=0
pdf.text "  : #{@order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext # ", :size => 9, :style => :bold, :at =>[150,544]

if @order.client.home_extension.size!=0
pdf.text "  : #{@order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #  " , :size => 9, :style => :bold, :at =>[10,532]

if @order.client.direct_phone.size!=0
pdf.text "  : #{@order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #  " , :size => 9, :style => :bold, :at =>[10,520]

if @order.client.mobile_phone.size!=0
pdf.text "  : #{@order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,520]
end


if @notary!=nil
pdf.text "               Notary  " , :size => 9, :style => :bold, :at =>[10,508]
pdf.text "  : #{@notary_first_name} #{@notary_last_name}" , :size => 8, :at =>[75,508]
pdf.text "  NotaryFly ID #  " , :size => 9, :style => :bold, :at =>[10,496]
pdf.text "  : #{@notary_id}" , :size => 8, :at =>[75,496]
pdf.text "      Notary Fee  " , :size => 9, :style => :bold, :at =>[10,484]

if @order.notary_fee!=nil
pdf.text "  : $#{number_with_precision(@order.notary_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,484]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,484]
end
pdf.text "      Other Fee  " , :size => 9, :style => :bold, :at =>[10,472]
if @order.travel_fee!=nil
pdf.text "  : $#{number_with_precision(@order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,472]
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,472]
end
pdf.text "      Explanation : " , :size => 9, :style => :bold, :at =>[10,460]
i=460
if @order.other_fee_reason!=nil
word_wrap(@order.other_fee_reason,35).split("\n").each() do |explanation|
  if i>=448
 pdf.text explanation, :size => 9, :at => [83,i]
 i=i-12
end
end
else
pdf.text "  : Not Provided" , :size => 8, :at =>[75,448]
end
pdf.text "Total Notary Fee  " , :size => 9, :style => :bold, :at =>[8,436]

if @order.notary_fee!=nil && @order.travel_fee!=nil
 pdf.text "  : $#{number_with_precision(@order.notary_fee.to_f + @order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
elsif @order.notary_fee!=nil && @order.travel_fee==nil
pdf.text "  : $#{number_with_precision(@order.notary_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
elsif @order.notary_fee==nil && @order.travel_fee!=nil
pdf.text "  : $#{number_with_precision(@order.travel_fee.to_f,:precision=>2)}" , :size => 8, :at =>[75,436]
else
pdf.text "  : $ 0.00" , :size => 8, :at =>[75,436]
end


pdf.text "                 Day #  " , :size => 9, :style => :bold, :at =>[10,424]
pdf.text "  : #{@notary_day_phone}" , :size => 8, :at =>[75,424]

pdf.text "         Evening #   " , :size => 9, :style => :bold, :at =>[10,412]
pdf.text "  : #{@notary_evening_phone}" , :size => 8, :at =>[75,412]

pdf.text "           Mobile #   " , :size => 9, :style => :bold, :at =>[10,400]
pdf.text "  : #{@notary_mobile_phone}" , :size => 8, :at =>[75,400]

pdf.text "              Work #   " , :size => 9, :style => :bold, :at =>[10,388]
pdf.text "  : #{@notary_work_phone}" , :size => 8, :at =>[75,388]


pdf.text "                Email   " , :size => 9, :style => :bold, :at =>[10,376]
pdf.text "  : #{@notary_user_email}" , :size => 8, :at =>[75,376]
end



pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date", :size => 9, :style => :bold, :at => [320,620]
pdf.text "      : #{@order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "      : #{@order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "      : #{@order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "      : #{@order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s)   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "      : #{@order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs Sent via   ", :size => 9, :style => :bold, :at => [320,560]

if @order.shipped_via.size!=0
pdf.text "      : #{@order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #   ", :size => 9, :style => :bold, :at => [320,548]

if @order.tracking_number.size!=0
pdf.text "      : #{@order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,548]
end

if  @order.signing_location_address.length < 36
pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "         #{@order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
else
i=536

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
word_wrap(@order.signing_location_address,35).split("\n").each() do |loc|
j="       "
if i>=524
pdf.text  j+loc, :size => 9, :at => [385,i]
i=i-12;
end
end
pdf.text "              Location   ", :size => 9, :style => :bold, :at => [320,512]
end

pdf.text "      : #{@order.signing_location_city}, #{@order.signing_location_state} #{@order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer #1   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "      : #{@order.borrower_1_first_name} #{@order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #   " , :size => 9, :style => :bold, :at => [320,476]
if @order.borrower_1_work_phone.size!=0
pdf.text "      : #{@order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,476]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,476]
if @order.borrower_1_extension.size!=0
pdf.text "      : #{@order.borrower_1_extension}", :size => 8, :at => [479,476]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,476]
end

pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,464]
if @order.borrower_1_home_phone.size!=0
pdf.text "      : #{@order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,452]

if @order.borrower_1_mobile_phone.size!=0
pdf.text "      : #{@order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer #2    " , :size => 9, :style => :bold, :at => [320,428]
if @order.borrower_2_first_name.size!=0 or @order.borrower_2_last_name.size!=0
pdf.text "      : #{@order.borrower_2_first_name} #{@order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                  Work #    " , :size => 9, :style => :bold, :at => [320,416]
if @order.borrower_2_work_phone.size!=0
pdf.text "      : #{@order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Ext #   " , :size => 9, :style => :bold, :at => [425,416]
if @order.borrower_1_extension.size!=0
pdf.text "      : #{@order.borrower_2_extension}", :size => 8, :at => [479,416]
else
pdf.text "      : Not Provided", :size => 8, :at => [479,416]
end

pdf.text "                 Home #   " , :size => 9, :style => :bold, :at => [320,404]
if @order.borrower_2_home_phone.size!=0
pdf.text "      : #{@order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                Mobile #   " , :size => 9, :style => :bold, :at => [320,392]
if @order.borrower_2_mobile_phone.size!=0
pdf.text "      : #{@order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "      : Not Provided", :size => 8, :at => [385,392]
end



pdf.text "Return Documents To:", :size => 10, :style => :bold, :at => [0,340]
pdf.text "#{@order.return_company_name}", :size => 9, :at => [10,320]
pdf.text "Attn : #{@order.return_attention}", :size => 9, :at => [10,308]
pdf.text "#{@order.return_address}", :size => 9, :at => [10,296]
pdf.text "#{@order.return_city}, #{@order.return_state} #{@order.return_zip_code}", :size => 9, :at => [10,284]
pdf.text "#{@order.return_shipping_courier} Acct#: #{@order.return_account_number}", :size => 9, :at => [10,272]

pdf.text "Broker/Loan Officer Contact Information:", :size => 10, :style => :bold, :at => [300,340]
if @agent!=nil
pdf.text "#{@agent_company_name}", :size => 9, :at => [320,320]
pdf.text "#{@agent_broker_name}", :size => 9, :at => [320,308]
pdf.text "#{@agent_address}", :size => 9, :at => [320,296]
pdf.text "#{@agent_city}, #{@agent_state} #{@agent_zip_code}", :size => 9, :at => [320,284]

pdf.text "Telephone #: #{@agent_home_phone}", :size => 9, :at => [320,272]

pdf.text "Ext: #{@agent_home_extension}", :size => 9, :at => [450,272]

pdf.text "Cell #: #{@agent_mobile_phone}", :size => 9, :at => [320,260]

else
pdf.text "Not Provided", :size => 9, :at => [320,296]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,235]

i=220
if @order.special_instructions!=nil
word_wrap(@order.special_instructions,123).split("\n").each() do |instruction|
if i>64
pdf.text instruction, :size => 9, :at => [5,i]
i=i-12
end
end
end


pdf.text "For Order Status updates, visit http://www.notaryfly.com", :size => 9, :at => [0,35]
pdf.text "Are there any Lenders,Title or Escrow companies who would benefit from Notaryfly?" , :at => [0,23], :size => 9
pdf.text "Do you know any loan officers or brokers who would need better communication with their loan closings? " , :at => [0,11], :size => 9
pdf.text "If so forward contact info to: referafriend@notaryfly.com", :at => [0,0], :size => 9