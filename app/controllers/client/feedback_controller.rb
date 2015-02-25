class Client::FeedbackController < ApplicationController
  include SslRequirement
  ssl_required  :buy_credits
  before_filter :credits
end
