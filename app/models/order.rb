require 'pdfkit'
class Order < ActiveRecord::Base
    include ActionView::Helpers::NumberHelper
  cattr_reader :per_page
  @@per_page = 10

  belongs_to :client
  belongs_to :notary
  belongs_to :agent
  has_many :order_executives
  has_many :executives, :through => :order_executives
  has_many :messages
  has_many :notes

  has_many :multiple_notaries
  
  has_one :order_feedback
  
  has_many :order_attachments, :dependent => :destroy
  accepts_nested_attributes_for :order_attachments
  
  has_attached_file :order_attachment_1
  has_attached_file :order_attachment_2
  has_attached_file :order_attachment_3
  has_attached_file :order_attachment_4
  has_attached_file :order_attachment_5
  has_attached_file :order_attachment_6

  def self.messages_for_individual_order(order_id,user_id)

    @total_messages = Message.find(:all, :conditions => ["order_id = ? AND recipient_id = ?", order_id,user_id])
    return @total_messages.size

  end

  def self.details(order_id)
    @order = Order.find(order_id)
    if @order.notary_id
      @notary = Notary.find(@order.notary_id)
    end
    return @notary
  end


  def self.total_siging(user_id)
    
    @notaryid = Notary.find_by_user_id(user_id)
    if @notaryid
      @orders = Order.find_all_by_notary_id(@notaryid.id,:conditions => ["status = 'closed'"])
      return @orders.size
    end
  end
  
  def self.update_order_status
  end
  
  def customer_invoice(order)
    @order = order
    if order.notary_id
      @notary = Notary.find(order.notary_id)
    end

    if order.client_id
      @client = Client.find(order.client_id)
    end

    if order.agent_id
      @agent = Agent.find_by_id(order.agent_id)
    end
    
    html= "
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Invoice Notary 11</title>
</head>
<style>
	th, tr, td {vertical-align:top !important;}
	body {width:100%; margin:0 auto;}
</style>

<body>
<table cellpadding='0' cellspacing='0' width='100%' border='0' style='background: url(#{RAILS_ROOT}/public/logo/header-bg.png) repeat-x #fff; border:1px solid #000; border-bottom:0px;' >
    <tbody>
       <tr>
           <td width='300px'><img border='0px' src='#{RAILS_ROOT}/public/logo/notary-logo.png' /></td>
       </tr>
       <tr>
           <td width='100%' valign='top' style='padding: 0in 5.4pt; width: 513.1pt;'>
           <p style='margin:4px 0px;'>
           <span style='font-size:25px; font-family:Trebuchet MS; line-height:25px; text-transform:uppercase;' >WORK ORDER DETAILS</span></p>
           </td>
       </tr>
   </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:5px;' >
	<tbody style='font:bold 14px Arial, Helvetica, sans-serif; text-transform:uppercase; text-align:center; border:1px solid #000;'>
       <tr >
           <td>NF #</td>
           <td>ESCROW #</td>
           <td>SIGNER</td>
           <td>SIGNING DATE</td>
           <td>SIGNING TIME</td>
           <td>TOTAL FEE</td>
       </tr>
       <tr>
           <td>#{@order.id}</td>
           <td>#{@order.loan_number}</td>
           <td>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</td>
           <td>#{@order.signing_date.strftime('%m/%d/%Y')}</td>
           <td>#{@order.signing_time}</td>
           <td>$#{number_with_precision(@order.client.customer_fee.to_f, :precision=>2)}</td>
       </tr>
    </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;'>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNER 1</td>
                <td width='50%'>SIGNER 2</td>
            </tr>
            <tr>
            <td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>" 
    if @order.borrower_1_home_phone.length !=0
      html+="#{@order.borrower_1_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_1_work_phone.length !=0
      html+="#{@order.borrower_1_work_phone }"
    end
    if @order.borrower_1_extension.length !=0
      html+= "- Ext #{@order.borrower_1_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_2_last_name}&nbsp;#{@order.borrower_2_first_name}</span>"             
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>"
    if @order.borrower_2_home_phone.length!=0
      html+="#{@order.borrower_2_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_2_work_phone.length!=0
      html+="#{@order.borrower_2_work_phone}"
    end
    if @order.borrower_2_extension.length!=0
      html+="- Ext"
      html+=" #{@order.borrower_2_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="</tr>
        </tbody>
    </table>"
    html+="<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNING LOCATION</td>
                <td>LOAN OFFICER/BROKER INFO</td>
            </tr>
            <tr>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.signing_location_address}<br>
            #{@order.signing_location_city}, #{@order.signing_location_state} #{@order.signing_location_zip_code}</span>                 
            </td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@agent.broker_name}</span>"                 
                
    if @agent.home_phone.size!=0
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
      html+="#{@agent.home_phone} "
    end
    if @agent.home_extension.size!=0
      html+="Ext: #{@agent.home_extension}</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><a href='#'>#{@agent.email}</a></span>
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td>CUSTOMER INFO</td>
                <td>NOTARY INFO</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Escrow/Title Company: #{@order.client.company_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Contact Person: #{@order.client.client_name}</span>"
    if @order.client.home_phone.size!=0
      html+= "<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone # #{@order.client.home_phone} Ext #:"
      if @order.client.home_extension.size!=0
        html+="#{@order.client.home_extension}"
      end
      html+="</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.address} </span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.city}, #{@order.client.state} #{@order.client.zip_code}</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.user.email}</span>
            </td>
            <td style='width50%;'>"
    if @notary
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
             
      html+="#{@notary.last_name} #{@notary.first_name }</span>"
                
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone #"
      if @notary && @notary.mobile_phone.length!=0
        html+="#{@notary.mobile_phone}"
      end
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_address }</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_city} #{@order.order_notary_contact_state} #{@order.order_notary_contact_zip_code}"
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@notary.user.email}</span>"
    else
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Not assigned</span>
      </td>"
    end
    html+="</tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>ORDER SPECIFIC INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto;min-height:50px;'>
                </span>                 
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>SPECIAL INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto ;min-height:50px;'>#{@order.special_instructions}</span>                 
            </td>
            </tr>
        </tbody>
    </table>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='0' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; ' >
    <tbody>
       <tr>
       	<td>
           <span style='width:100%; display:block; text-align:center; font:italic 12px Trebuchet MS; margin-bottom:7px;'>Please remit Total Signing Fee as soon as loan funds. Save time and trees – Pay electronically</span>
           <span style='width:100%; display:block; text-align:center; font:bold 14px Trebuchet MS; margin-bottom:7px;'>WE APPRECIATE YOUR BUSINESS!</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px;'>NotaryFly.com * 800-470-7515 * 120 Tustin Ave Suite C-1214 * Newport Beach, CA  92663</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px; height:25px; background: url(#{RAILS_ROOT}/public/logo/footer-bg.png) repeat-x #fff; border-bottom:1px solid #365f91;'></span>
         </td>
       </tr>
   </tbody>
</table>
  </body>
</html>"

    
    
    #PDFKit.new(html, :margin_top    => '0.2in', :margin_right  => '0.2in', :margin_bottom => '0.5in', :margin_left   => '0.2in' )
    PDFKit.new(html, :page_size => 'A4' )
  end
  
  def notary_invoice(order)
    @order = order
    if order.notary_id
      @notary = Notary.find(order.notary_id)
    end

    if order.client_id
      @client = Client.find(order.client_id)
    end

    if order.agent_id
      @agent = Agent.find_by_id(order.agent_id)
    end
    
    html= "
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Invoice Notary 11</title>
</head>
<style>
	th, tr, td {vertical-align:top !important;}
	body {width:100%; margin:0 auto;}
</style>

<body>
<table cellpadding='0' cellspacing='0' width='100%' border='0' style='background: url(#{RAILS_ROOT}/public/logo/header-bg.png) repeat-x #fff; border:1px solid #000; border-bottom:0px;' >
    <tbody>
       <tr>
           <td width='300px'><img border='0px' src='#{RAILS_ROOT}/public/logo/notary-logo.png' /></td>
       </tr>
       <tr>
           <td width='100%' valign='top' style='padding: 0in 5.4pt; width: 513.1pt;'>
           <p style='margin:4px 0px;'>
           <span style='font-size:25px; font-family:Trebuchet MS; line-height:25px; text-transform:uppercase;' >WORK ORDER DETAILS</span></p>
           </td>
       </tr>
   </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:5px;' >
	<tbody style='font:bold 14px Arial, Helvetica, sans-serif; text-transform:uppercase; text-align:center; border:1px solid #000;'>
       <tr >
           <td>NF #</td>
           <td>ESCROW #</td>
           <td>SIGNER</td>
           <td>SIGNING DATE</td>
           <td>SIGNING TIME</td>
           <td>NOTARY FEE</td>
       </tr>
       <tr>
           <td>#{@order.id}</td>
           <td>#{@order.loan_number}</td>
           <td>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</td>
           <td>#{@order.signing_date.strftime('%m/%d/%Y')}</td>
           <td>#{@order.signing_time}</td>
           <td>#{@order.notary.nil? ? "Notary not assigned" : "$#{number_with_precision(@order.notary.fee.to_f, :precision => 2)}"}</td>
       </tr>
    </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;'>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNER 1</td>
                <td width='50%'>SIGNER 2</td>
            </tr>
            <tr>
            <td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>" 
    if @order.borrower_1_home_phone.length !=0
      html+="#{@order.borrower_1_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_1_work_phone.length !=0
      html+="#{@order.borrower_1_work_phone }"
    end
    if @order.borrower_1_extension.length !=0
      html+= "- Ext #{@order.borrower_1_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_2_last_name}&nbsp;#{@order.borrower_2_first_name}</span>"             
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>"
    if @order.borrower_2_home_phone.length!=0
      html+="#{@order.borrower_2_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_2_work_phone.length!=0
      html+="#{@order.borrower_2_work_phone}"
    end
    if @order.borrower_2_extension.length!=0
      html+="- Ext"
      html+=" #{@order.borrower_2_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="</tr>
        </tbody>
    </table>"
    html+="<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNING LOCATION</td>
                <td>LOAN OFFICER/BROKER INFO</td>
            </tr>
            <tr>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.signing_location_address}<br>
            #{@order.signing_location_city}, #{@order.signing_location_state} #{@order.signing_location_zip_code}</span>                 
            </td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@agent.broker_name}</span>"                 
                
    if @agent.home_phone.size!=0
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
      html+="#{@agent.home_phone} "
    end
    if @agent.home_extension.size!=0
      html+="Ext: #{@agent.home_extension}</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><a href='#'>#{@agent.email}</a></span>
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td>CUSTOMER INFO</td>
                <td>NOTARY INFO</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Escrow/Title Company: #{@order.client.company_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Contact Person: #{@order.client.client_name}</span>"
    if @order.client.home_phone.size!=0
      html+= "<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone # #{@order.client.home_phone} Ext #:"
      if @order.client.home_extension.size!=0
        html+="#{@order.client.home_extension}"
      end
      html+="</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.address} </span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.city}, #{@order.client.state} #{@order.client.zip_code}</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.user.email}</span>
            </td>
            <td style='width50%;'>"
    if @notary
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
             
      html+="#{@notary.last_name} #{@notary.first_name }</span>"
                
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone #"
      if @notary && @notary.mobile_phone.length!=0
        html+="#{@notary.mobile_phone}"
      end
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_address }</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_city} #{@order.order_notary_contact_state} #{@order.order_notary_contact_zip_code}"
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@notary.user.email}</span>"
    else
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Not assigned</span>
      </td>"
    end
    html+="</tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>ORDER SPECIFIC INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto;min-height:50px;'>
                </span>                 
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>SPECIAL INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto ;min-height:50px;'>#{@order.special_instructions}</span>                 
            </td>
            </tr>
        </tbody>
    </table>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='0' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; ' >
    <tbody>
       <tr>
       	<td>
           <span style='width:100%; display:block; text-align:center; font:italic 12px Trebuchet MS; margin-bottom:7px;'>We appreciate your hard work!  Please make sure your payment information is up to date so we can pay you ASAP!</span>
           <span style='width:100%; display:block; text-align:center; font:bold 14px Trebuchet MS; margin-bottom:7px;'>WE APPRECIATE YOUR BUSINESS!</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px;'>NotaryFly.com * 800-470-7515 * 120 Tustin Ave Suite C-1214 * Newport Beach, CA  92663</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px; height:25px; background: url(#{RAILS_ROOT}/public/logo/footer-bg.png) repeat-x #fff; border-bottom:1px solid #365f91;'></span>
         </td>
       </tr>
   </tbody>
</table>
  </body>
</html>"

    
    
    #PDFKit.new(html, :margin_top    => '0.2in', :margin_right  => '0.2in', :margin_bottom => '0.5in', :margin_left   => '0.2in' )
    PDFKit.new(html, :page_size => 'A4' )
  end
  
  def admin_invoice(order)
    @order = order
    if order.notary_id
      @notary = Notary.find(order.notary_id)
    end

    if order.client_id
      @client = Client.find(order.client_id)
    end

    if order.agent_id
      @agent = Agent.find_by_id(order.agent_id)
    end
    
    html= "
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml'>
<head>
<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
<title>Invoice Notary 11</title>
</head>
<style>
	th, tr, td {vertical-align:top !important;}
	body {width:100%; margin:0 auto;}
</style>

<body>
<table cellpadding='0' cellspacing='0' width='100%' border='0' style='background: url(#{RAILS_ROOT}/public/logo/header-bg.png) repeat-x #fff; border:1px solid #000; border-bottom:0px;' >
    <tbody>
       <tr>
           <td width='300px'><img border='0px' src='#{RAILS_ROOT}/public/logo/notary-logo.png' /></td>
       </tr>
       <tr>
           <td width='100%' valign='top' style='padding: 0in 5.4pt; width: 513.1pt;'>
           <p style='margin:4px 0px;'>
           <span style='font-size:25px; font-family:Trebuchet MS; line-height:25px; text-transform:uppercase;' >WORK ORDER DETAILS</span></p>
           </td>
       </tr>
   </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:5px;' >
	<tbody style='font:bold 14px Arial, Helvetica, sans-serif; text-transform:uppercase; text-align:center; border:1px solid #000;'>
       <tr >
           <td>NF #</td>
           <td>ESCROW #</td>
           <td>SIGNER</td>
           <td>SIGNING DATE</td>
           <td>SIGNING TIME</td>
           <td>TOTAL FEE</td>
           <td>NOTARY FEE</td>
           <td>NF NET FEE</td>
       </tr>
       <tr>
           <td>#{@order.id}</td>
           <td>#{@order.loan_number}</td>
           <td>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</td>
           <td>#{@order.signing_date.strftime('%m/%d/%Y')}</td>
           <td>#{@order.signing_time}</td>
           <td>$#{number_with_precision(@order.client.customer_fee.to_f, :precision => 2)}</td>
           <td>#{@order.notary.nil? ? "Notary not assigned" : "$#{number_with_precision(@order.notary.fee.to_f, :precision => 2)}"}</td>
           <td>$#{number_with_precision((@order.client.customer_fee.to_f-(@order.travel_fee.to_f+ @order.notary.fee.to_f)).to_f, :precision=>2)}</td>
       </tr>
    </tbody>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;'>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNER 1</td>
                <td width='50%'>SIGNER 2</td>
            </tr>
            <tr>
            <td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_1_last_name},&nbsp;#{@order.borrower_1_first_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>" 
    if @order.borrower_1_home_phone.length !=0
      html+="#{@order.borrower_1_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_1_work_phone.length !=0
      html+="#{@order.borrower_1_work_phone }"
    end
    if @order.borrower_1_extension.length !=0
      html+= "- Ext #{@order.borrower_1_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.borrower_2_last_name}&nbsp;#{@order.borrower_2_first_name}</span>"             
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Primary Phone #</strong>"
    if @order.borrower_2_home_phone.length!=0
      html+="#{@order.borrower_2_home_phone}"
    end
    html+="</span>"
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><strong>Secondary Phone #</strong>"
    if @order.borrower_2_work_phone.length!=0
      html+="#{@order.borrower_2_work_phone}"
    end
    if @order.borrower_2_extension.length!=0
      html+="- Ext"
      html+=" #{@order.borrower_2_extension}"
    end
    html+="</span>"
    html+="</td>"
    html+="</tr>
        </tbody>
    </table>"
    html+="<table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none; margin-bottom:-1px;'>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td width='50%'>SIGNING LOCATION</td>
                <td>LOAN OFFICER/BROKER INFO</td>
            </tr>
            <tr>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.signing_location_address}<br>
            #{@order.signing_location_city}, #{@order.signing_location_state} #{@order.signing_location_zip_code}</span>                 
            </td>"
    html+="<td style='width50%;'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@agent.broker_name}</span>"                 
                
    if @agent.home_phone.size!=0
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
      html+="#{@agent.home_phone} "
    end
    if @agent.home_extension.size!=0
      html+="Ext: #{@agent.home_extension}</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'><a href='#'>#{@agent.email}</a></span>
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td>CUSTOMER INFO</td>
                <td>NOTARY INFO</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Escrow/Title Company: #{@order.client.company_name}</span>                 
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Contact Person: #{@order.client.client_name}</span>"
    if @order.client.home_phone.size!=0
      html+= "<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone # #{@order.client.home_phone} Ext #:"
      if @order.client.home_extension.size!=0
        html+="#{@order.client.home_extension}"
      end
      html+="</span>"
    end
    html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.address} </span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.city}, #{@order.client.state} #{@order.client.zip_code}</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.client.user.email}</span>
            </td>
            <td style='width50%;'>"
    if @notary
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>"
             
      html+="#{@notary.last_name} #{@notary.first_name }</span>"
                
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Phone #"
      if @notary && @notary.mobile_phone.length!=0
        html+="#{@notary.mobile_phone}"
      end
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_address }</span>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@order.order_notary_contact_city} #{@order.order_notary_contact_state} #{@order.order_notary_contact_zip_code}"
      html+="</span>"
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>#{@notary.user.email}</span>"
    else
      html+="<span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS;'>Not assigned</span>
      </td>"
    end
    html+="</tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>ORDER SPECIFIC INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto;min-height:50px;'>
                </span>                 
            </td>
            </tr>
        </tbody>
    </table>
    <table cellpadding='2' cellspacing='0' width='100%' border='1' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; '>
        <tbody >
            <tr bgcolor='#dbe5f1' style='font:bold 16px Trebuchet MS; text-transform:uppercase;'>
                <td style='text-align:center;'>SPECIAL INSTRUCTIONS</td>
            </tr>
            <tr>
            <td width='50%'>
                <span style='width:100%; display:block; padding:2px 0; font:normal 14px Trebuchet MS; height:auto ;min-height:50px;'>#{@order.special_instructions}</span>                 
            </td>
            </tr>
        </tbody>
    </table>
</table>
<table cellpadding='2' cellspacing='0' width='100%' border='0' bordercolor='#000' style='border-collapse: collapse; border: medium none;margin-bottom:-1px; ' >
    <tbody>
       <tr>
       	<td>
           <span style='width:100%; display:block; text-align:center; font:italic 12px Trebuchet MS; margin-bottom:7px;'>Please remit Notary Fee as soon as loan funds. Save time and trees - Pay electronically</span>
           <span style='width:100%; display:block; text-align:center; font:bold 14px Trebuchet MS; margin-bottom:7px;'>WE APPRECIATE YOUR BUSINESS!</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px;'>NotaryFly.com * 800-470-7515 * 120 Tustin Ave Suite C-1214 * Newport Beach, CA  92663</span>
           <span style='width:100%; display:block; text-align:center; font:normal 14px Trebuchet MS; margin-bottom:7px; height:25px; background: url(#{RAILS_ROOT}/public/logo/footer-bg.png) repeat-x #fff; border-bottom:1px solid #365f91;'></span>
         </td>
       </tr>
   </tbody>
</table>
  </body>
</html>"

    
    
    #PDFKit.new(html, :margin_top    => '0.2in', :margin_right  => '0.2in', :margin_bottom => '0.5in', :margin_left   => '0.2in' )
    PDFKit.new(html, :page_size => 'A4' )
  end
  
  
end
