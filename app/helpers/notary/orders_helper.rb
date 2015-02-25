module Notary::OrdersHelper
  def sort_by_pending_orders
    filters = ['Borrower Name', 'Signing Date', 'Escrow Number']
    select_tag :filter, options_for_select(filters.collect {|f| [f, f]}, params[:filter]), :onchange => "this.form.submit()", :style => "display: inline; vertical-align: middle"
  end
end
