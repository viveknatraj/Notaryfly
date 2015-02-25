class OrderFeedback < ActiveRecord::Base
  belongs_to :order

  def self.feedback_percentage(notary_id)

    @tot_Percentage = 0

    @tot_Percentagexx = 0.0

    @feedback = OrderFeedback.find_all_by_notary_id(notary_id)

    for feed in @feedback

      @tot_Percentage += feed.accuracy.to_i+feed.communication.to_i+feed.punctuality.to_i+feed.fees.to_i+feed.professionalism.to_i

    end
  
     if @feedback.size.to_i!=0

      @totStars = 25

      @totalOrder = @feedback.size*@totStars

      @tot_Percentage = @tot_Percentage.to_f / @totalOrder.to_f

    end

    return Integer(@tot_Percentage*100)

  end


    def self.notary_feedback(user_id)

      @notary = Notary.find_by_user_id(user_id)
   # @orders = Order.find(:all, :conditions => ["notary_id = ? AND status = 'filled'", @notary.id ], :order => "created_at DESC")
    
      @tot_Percentage = 0
if @notary
    @feedback = OrderFeedback.find_all_by_notary_id(@notary.id)

      for feed in @feedback

        @tot_Percentage += feed.accuracy.to_i+feed.communication.to_i+feed.punctuality.to_i+feed.fees.to_i+feed.professionalism.to_i

      end

      if @feedback.size.to_i!=0

        @totStars = 25

        @totalOrder = @feedback.size*@totStars

        @tot_Percentage = @tot_Percentage.to_f / @totalOrder.to_f

      end

      return @tot_Percentage*5
end
    end

    def self.notary_ratings(user_id)

      @notary = Notary.find_by_user_id(user_id)

      @ratings = OrderFeedback.find_all_by_notary_id(@notary.id)

      return @ratings.size

    end


  def self.feedback_remainder

    @orders = Order.find(:all, :conditions => ["status = 'closed' AND feedback='needed' AND DATEDIFF(now(),created_at)<=60"])
  for @order in @orders
       @client = Client.find_by_id(@order.client_id)
    client_email = User.find(@client.user_id)
    client_email = client_email.email

    @notary = Notary.find(@order.notary_id)
    notary_email = User.find(@notary.user_id)
    notary_email = notary_email.email

    if @order.agent_id
    @agent = Agent.find_by_id(@order.agent_id)
    if @agent!=nil
              if @agent.notify_agent == "Yes"
              agent_email = @agent.email
             #  Notifier.deliver_agent_order_completed(@order,agent_email) #agent_email
              end
    end
    end

   Notifier.deliver_client_feedback_remainder_mail(@order,@agent,@notary, client_email)
  end
  end




end
