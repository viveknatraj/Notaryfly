class Notary::FeedbackController < ApplicationController
 before_filter :require_login_notary
  def index
    @notary = Notary.find_by_user_id(self.current_user.id)
    @order_feedbacks = OrderFeedback.find(:all, :conditions => ["notary_id = ?", @notary.id])
    if request.post?
      @order_feedback = OrderFeedback.find_by_order_id(params[:orderid])
      @order_feedback.update_attribute(:response_from_notary, params[:response_from_notary])
      @order_feedback.save
      session[:return_to] = request.fullpath
      redirect_to(session[:return_to])
    end
  end
  
  def detail
    @order_feedback = OrderFeedback.find(params[:id])
  end

end
