pdf.stroke_rectangle [0,635], 250, 270
pdf.stroke_rectangle [300,635], 250, 270


pdf.stroke_rectangle [0,335], 250, 85
pdf.stroke_rectangle [300,335], 250, 85

pdf.stroke_rectangle [0,230], 550, 100

pdf.text "NotaryFLY.com", :at => [0,720], :size => 20, :style => :bold
pdf.text "Work Order", :at => [350,720], :size => 17, :style => :bold
pdf.move_down(10)
pdf.text "Please visit http://www.notaryfly.com and login with your username and", :at => [5,665], :size => 8
pdf.text "password so you can provide up to date status on the signing.", :at => [5,655], :size => 8
pdf.move_down(10)
pdf.text "Notary Username:",:size=>10,:style=>:bold, :at => [5,655]

if @notary!=nil
pdf.text "  #{@order.notary.user.email}", :size => 8, :at =>[90,675]
end
pdf.text "Password:",:size=>10,:style=>:bold, :at => [5,655]
if @notary!=nil
pdf.text "  #{@order.notary.user.user_password}", :size => 8, :at =>[55,663]
end
pdf.move_down(15)

pdf.text "Work Order Details:", :size => 10, :style => :bold, :at => [0,640]
pdf.text "       NF Order #: ", :size => 9,:style => :bold, :at =>[15,620]
pdf.text "  #{@order.id}", :size => 8, :at =>[80,620]
pdf.text "           Escrow #: "  , :size => 9, :style => :bold, :at =>[10,608]
pdf.text "  #{@order.loan_number}", :size => 8, :at =>[80,608]
pdf.text "Scheduled Date: "  , :size => 9, :style => :bold, :at =>[10,596]
pdf.text "  #{@order.created_at.strftime('%m/%d/%Y')}", :size => 8, :at =>[80,596]
pdf.text "   Scheduled By: " , :size => 9, :style => :bold, :at =>[10,584]
pdf.text "  #{@order.client.company_name}", :size => 8, :at =>[80,584]
pdf.text "    #{@order.client.address}" , :size => 8, :at =>[75,576]
pdf.text "    #{@order.client.city} , #{@order.client.state} #{@order.client.zip_code}" , :size => 8, :at =>[75,568]
pdf.text "  Contact Name:  " , :size => 9, :style => :bold, :at =>[10,556]

if @order.client.client_name.size!=0
pdf.text "   #{@order.client.client_name}" , :size => 8, :at =>[75,556]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,556]
end

pdf.text "      Telephone #:  ", :size => 9, :style => :bold, :at =>[10,544]

if @order.client.home_phone.size!=0
pdf.text "   #{@order.client.home_phone}" , :size => 8, :at =>[75,544]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,544]
end

pdf.text "  Ext #: ", :size => 9, :style => :bold, :at =>[150,544]

if @order.client.home_extension.size!=0
pdf.text "   #{@order.client.home_extension}" , :size => 8, :at =>[175,544]
else
pdf.text "   Not Provided" , :size => 8, :at =>[175,544]
end

pdf.text "             Direct #:  " , :size => 9, :style => :bold, :at =>[10,532]

if @order.client.direct_phone.size!=0
pdf.text "   #{@order.client.direct_phone}" , :size => 8, :at =>[75,532]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,532]
end

pdf.text "            Mobile #:  " , :size => 9, :style => :bold, :at =>[10,520]

if @order.client.mobile_phone.size!=0
pdf.text "   #{@order.client.mobile_phone}" , :size => 8, :at =>[75,520]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,520]
end


if @notary!=nil
pdf.text "               Notary:  " , :size => 9, :style => :bold, :at =>[10,476]
pdf.text "   #{@order.notary.first_name} #{@order.notary.last_name}" , :size => 8, :at =>[75,476]
pdf.text "  NotaryFly ID #:  " , :size => 9, :style => :bold, :at =>[10,464]
pdf.text "   #{@order.notary.id}" , :size => 8, :at =>[75,464]
pdf.text "      Signing Fee:  " , :size => 9, :style => :bold, :at =>[10,452]


if @order.order_notary_fee!=nil
pdf.text "   $#{@order.order_notary_fee}" , :size => 8, :at =>[75,452]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,452]
end

pdf.text "                 Day #:  " , :size => 9, :style => :bold, :at =>[10,440]

if @order.notary.day_phone.size!=0
pdf.text "   #{@order.notary.day_phone}" , :size => 8, :at =>[75,440]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,440]
end

pdf.text "         Evening #:   " , :size => 9, :style => :bold, :at =>[10,428]

if @order.notary.evening_phone.size!=0
pdf.text "   #{@order.notary.evening_phone}" , :size => 8, :at =>[75,428]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,428]
end

pdf.text "           Mobile #:   " , :size => 9, :style => :bold, :at =>[10,416]
if @order.notary.mobile_phone.size!=0
pdf.text "   #{@order.notary.mobile_phone}" , :size => 8, :at =>[75,416]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,416]
end

pdf.text "              Work #:   " , :size => 9, :style => :bold, :at =>[10,404]

if @order.notary.work_phone.size!=0
pdf.text "   #{@order.notary.work_phone}" , :size => 8, :at =>[75,404]
else
pdf.text "   Not Provided" , :size => 8, :at =>[75,404]
end

pdf.text "                Email:   " , :size => 9, :style => :bold, :at =>[10,392]
pdf.text "   #{@order.notary.user.email}" , :size => 8, :at =>[75,392]
end



pdf.text "Signing Information:", :size => 10, :style => :bold, :at => [300,640]
pdf.text "       Signing Date:", :size => 9, :style => :bold, :at => [320,620]
pdf.text "       #{@order.signing_date.strftime('%m/%d/%Y')}", :size => 8, :at => [385,620]
pdf.text "       Signing Time: ", :size => 9, :style => :bold, :at => [320,608]
pdf.text "       #{@order.signing_time}", :size => 8, :at => [385,608]
pdf.text "Transaction Type:  ", :size => 9, :style => :bold, :at => [320,596]
pdf.text "       #{@order.loan_type}", :size => 8, :at => [385,596]
pdf.text "  Delivery Option:  ", :size => 9, :style => :bold, :at => [320,584]
pdf.text "       #{@order.delivery_options}", :size => 8, :at => [385,584]
pdf.text "Document Set(s):   ", :size => 9, :style => :bold, :at => [320,572]
pdf.text "       #{@order.sets_of_docs}", :size => 8, :at => [385,572]
pdf.text "      Docs sent via:   ", :size => 9, :style => :bold, :at => [320,560]

if @order.shipped_via.size!=0
pdf.text "       #{@order.shipped_via}", :size => 8, :at => [385,560]
else
pdf.text "       Not Provided", :size => 8, :at => [385,560]
end

pdf.text "            Tracking #:   ", :size => 9, :style => :bold, :at => [320,548]

if @order.tracking_number.size!=0
pdf.text "       #{@order.tracking_number}", :size => 8, :at => [385,548]
else
pdf.text "       Not Provided", :size => 8, :at => [385,548]
end

pdf.text "                Signing   ", :size => 9, :style => :bold, :at => [320,524]
pdf.text "         #{@order.signing_location_address}", :size => 8, :at => [385,524]
pdf.text "              Location:   ", :size => 9, :style => :bold, :at => [320,512]
pdf.text "         #{@order.signing_location_city}, #{@order.signing_location_state} #{@order.signing_location_zip_code}", :size => 8, :at => [385,512]

pdf.text "             Signer/Borrower #1:   ", :size => 9, :style => :bold, :at => [320,488]
pdf.text "         #{@order.borrower_1_first_name} #{@order.borrower_1_last_name}", :size => 8, :at => [385,488]

pdf.text "                  Work #:   " , :size => 9, :style => :bold, :at => [320,476]
if @order.borrower_1_work_phone.size!=0
pdf.text "         #{@order.borrower_1_work_phone}", :size => 8, :at => [385,476]
else
pdf.text "         Not Provided", :size => 8, :at => [385,476]
end


pdf.text "                 Home #:   " , :size => 9, :style => :bold, :at => [320,464]
if @order.borrower_1_home_phone.size!=0
pdf.text "         #{@order.borrower_1_home_phone}", :size => 8, :at => [385,464]
else
pdf.text "         Not Provided", :size => 8, :at => [385,464]
end

pdf.text "                Mobile #:   " , :size => 9, :style => :bold, :at => [320,452]

if @order.borrower_1_mobile_phone.size!=0
pdf.text "         #{@order.borrower_1_mobile_phone}", :size => 8, :at => [385,452]
else
pdf.text "         Not Provided", :size => 8, :at => [385,452]
end

pdf.text "              Signer/Borrower #2:    " , :size => 9, :style => :bold, :at => [320,428]
if @order.borrower_2_first_name.size!=0 or @order.borrower_2_last_name.size!=0
pdf.text "         #{@order.borrower_2_first_name} #{@order.borrower_2_last_name}", :size => 8, :at => [385,428]
else
pdf.text "         Not Provided", :size => 8, :at => [385,428]
end

pdf.text "                   Work #:    " , :size => 9, :style => :bold, :at => [320,416]
if @order.borrower_2_work_phone.size!=0
pdf.text "         #{@order.borrower_2_work_phone}", :size => 8, :at => [385,416]
else
pdf.text "         Not Provided", :size => 8, :at => [385,416]
end

pdf.text "                  Home #:   " , :size => 9, :style => :bold, :at => [320,404]
if @order.borrower_2_home_phone.size!=0
pdf.text "         #{@order.borrower_2_home_phone}", :size => 8, :at => [385,404]
else
pdf.text "         Not Provided", :size => 8, :at => [385,404]
end

pdf.text "                 Mobile #:   " , :size => 9, :style => :bold, :at => [320,392]
if @order.borrower_2_mobile_phone.size!=0
pdf.text "         #{@order.borrower_2_mobile_phone}", :size => 8, :at => [385,392]
else
pdf.text "         Not Provided", :size => 8, :at => [385,392]
end



pdf.text "Return Documents To:", :size => 10, :style => :bold, :at => [0,340]
pdf.text "#{@order.return_company_name}", :size => 9, :at => [10,320]
pdf.text "Attn : #{@order.return_attention}", :size => 9, :at => [10,308]
pdf.text "#{@order.return_address}", :size => 9, :at => [10,296]
pdf.text "#{@order.return_city}, #{@order.return_state} #{@order.return_zip_code}", :size => 9, :at => [10,284]
pdf.text "#{@order.return_shipping_courier} Acct#: #{@order.return_account_number}", :size => 9, :at => [10,272]

pdf.text "Agent Contact Information:", :size => 10, :style => :bold, :at => [300,340]
if @agent!=nil
pdf.text "#{@agent.company_name}", :size => 9, :at => [320,320]
pdf.text "#{@agent.broker_name}", :size => 9, :at => [320,308]
pdf.text "#{@agent.address}", :size => 9, :at => [320,296]

if @agent.city!=nil and @agent.city.length!=0 and @agent.state!=nil and @agent.state.length!=0
pdf.text "#{@agent.city}, #{@agent.state} #{@agent.zip_code}", :size => 9, :at => [320,284]
else
pdf.text "#{@agent.city} #{@agent.state} #{@agent.zip_code}", :size => 9, :at => [320,284]
end

if @agent.home_phone.size!=0
pdf.text "Telephone #: #{@agent.home_phone}", :size => 9, :at => [320,272]
else
pdf.text "Telephone #: Not Provided", :size => 9, :at => [320,272]
end

if @agent.home_extension.size!=0
pdf.text "Ext: #{@agent.home_extension}", :size => 9, :at => [450,272]
else
pdf.text "Ext: Not Provided", :size => 9, :at => [450,272]
end

if @agent.mobile_phone.size!=0
pdf.text "Cell #: #{@agent.mobile_phone}", :size => 9, :at => [320,260]
else
pdf.text "Cell #: Not Provided", :size => 9, :at => [320,260]
end

else
pdf.text "Not Provided", :size => 9, :at => [320,296]
end


pdf.text "Signing Instructions:", :size => 10, :style => :bold, :at => [0,235]

if @order.special_instructions.size!=0
pdf.text "#{@order.special_instructions}", :size => 9, :at => [5,220]
else
pdf.text "Not Provided", :size => 9, :at => [5,220]
end


pdf.text "NotaryFLY.com is a venue for hiring company and notary to find each other for the purpose of performing notary signings. Any agreements", :size => 9, :at => [0,95]
pdf.text "made are solely between notary (independent contractor) and hiring company. Notary is responsible for invoicing and collecting payment for", :size => 9, :at => [0,83]
pdf.text "job performed. NotaryFLY.com is not responsible for payment for any reason.", :size => 9, :at => [0,71]