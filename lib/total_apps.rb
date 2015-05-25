require 'rubygems'
require 'curb'
require 'uri'
require 'addressable/uri'



class GwApi
    def initialize()
        @login = {}
        @order = {}
        @billing = {}
        @shipping = {}
        @responses = {}
    end

    def setLogin(username,password)
        @login['password'] = password
        @login['username'] = username
    end

    def setOrder( orderid, orderdescription, tax, shipping, ponumber,ipadress)
        @order['orderid'] = orderid;
        @order['orderdescription'] = orderdescription
        @order['shipping'] = "%.2f" % shipping
        @order['ipaddress'] = ipadress
        @order['tax'] = "%.2f" % tax
        @order['ponumber'] = ponumber
    end

    def setBilling(
            firstname,
            lastname,
            company,
            address1,
            address2,
            city,
            state,
            zip,
            country,
            phone,
            fax,
            email,
            website)
        @billing['firstname'] = firstname
        @billing['lastname']  = lastname
        @billing['company']   = company
        @billing['address1']  = address1
        @billing['address2']  = address2
        @billing['city']      = city
        @billing['state']     = state
        @billing['zip']       = zip
        @billing['country']   = country
        @billing['phone']     = phone
        @billing['fax']       = fax
        @billing['email']     = email
        @billing['website']   = website
    end

    def setShipping(firstname,
            lastname,
            company,
            address1,
            address2,
            city,
            state,
            zipcode,
            country,
            email)
        @shipping['firstname'] = firstname
        @shipping['lastname']  = lastname
        @shipping['company']   = company
        @shipping['address1']  = address1
        @shipping['address2']  = address2
        @shipping['city']      = city
        @shipping['state']     = state
        @shipping['zip']       = zipcode
        @shipping['country']   = country
        @shipping['email']     = email

    end

    def doSale(amount, ccnumber, ccexp, cvv='')

        query  = ""
        # Login Information

        query = query + "username=" + URI.escape(@login['username']) + "&"
        query += "password=" + URI.escape(@login['password']) + "&"
        # Sales Information
        query += "ccnumber=" + URI.escape(ccnumber) + "&"
        query += "ccexp=" + URI.escape(ccexp) + "&"
        query += "amount=" + URI.escape("%.2f" %amount) + "&"
        query += "currency=" + URI.escape("USD") + "&"
        if (cvv!='')
            query += "cvv=" + URI.escape(cvv) + "&"
        end
        # Order Information
        @order.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end

        # Billing Information
        @billing.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end
        # Shipping Information

        @shipping.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end

        query += "type=sale"
        return doPost(query)
    end

    def doCredit(amount, account_no, routing_no, account_type, account_holder_type, check_name )

        query  = ""
								begin
        # Login Information
        query = query + "username=" + URI.escape(@login['username']) + "&"
        query += "password=" + URI.escape(@login['password']) + "&"
        query += "amount=" + URI.escape("%.2f" %amount) + "&"
        # ACH Information
        #query += "amount=" + URI.escape("%.2f" %amount) + "&"
        query += "checkaccount=" + URI.escape(account_no) + "&"
        query += "checkaba=" + URI.escape(routing_no) + "&"
        query += "account_type=" + URI.escape(account_type) + "&"
        query += "account_holder_type=" + URI.escape(account_holder_type) + "&"
        query += "checkname=" + URI.escape(check_name) + "&"
        query += "sec_code=" + URI.escape("PPD") + "&"
        query += "payment=" + URI.escape("check") + "&"
        # Order Information
        @order.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end

        # Billing Information
        @billing.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end
        # Shipping Information

        @shipping.each do | key,value|
            query += key +"=" + URI.escape(value) + "&"
        end
        query += "type=credit"
								p "QUERY: #{query}"
								rescue Exception => e
																return e.inspect
								end
        return doPost(query)
    end

    def doPost(query)


        curlObj = Curl::Easy.new("https://secure.total-apps-gateway.com/api/transact.php")
        curlObj.connect_timeout = 15
        curlObj.timeout = 15
        curlObj.header_in_body = false
        curlObj.ssl_verify_peer=false
        curlObj.post_body = query
        curlObj.perform()
        data = curlObj.body_str

        # NOTE: The domain name below is simply used to create a full URI to allow URI.parse to parse out the query values
        # for us. It is not used to send any data
        data = '"https://secure.total-apps-gateway.com/api/transact.php?' + data
        uri = Addressable::URI.parse(data)
        p @responses = uri.query_values
        return @responses['response']
    end

    def getResponses()
        return @responses
    end
end


