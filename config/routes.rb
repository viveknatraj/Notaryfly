ActionController::Routing::Routes.draw do |map|
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'
  map.resources :passwords

  map.logout '/client/new', :controller => 'users', :action => 'new_client'
  map.logout '/notary/new', :controller => 'users', :action => 'new_notary'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.home '/', :controller => 'home', :action => 'index'
  map.notary '/notary/orders/cron_job', :controller => "notary/orders", :action => 'cron_job'
  map.notary '/notary/notaryflyu', :controller=> "notary/profile",:action => 'notaryflyu'
  map.admin '/admin/orders/index', :controller => "admin/orders", :action => 'index'
  map.admin '/admin/notaries/send_file', :controller => "admin/notaries", :action => 'send_file'
  map.admin '/admin/notaries/index', :controller => "admin/notaries", :action => 'index'
  map.admin '/admin/notaries/notary_fee', :controller=> 'admin/notaries', :action =>'notary_fee'
  map.admin '/admin/clients/index', :controller => "admin/clients", :action => 'index'
  map.admin '/admin/clients/promocode', :controller => "admin/clients", :action => 'promocode'
  map.admin '/admin/clients/add_credits', :controller => "admin/clients", :action => 'add_credits'
  map.admin '/admin/clients/settings', :controller => "admin/clients", :action => 'settings'
  map.admin '/admin/clients/assign_executive', :controller => "admin/clients", :action => 'assign_executive'

  map.admin '/admin/orders/open_order', :controller => "admin/orders", :action => 'open_order'
  map.admin '/admin/orders/pending_order', :controller => "admin/orders", :action => 'pending_order'
  map.admin '/admin/orders/order_history', :controller => "admin/orders", :action => 'order_history'
  map.admin '/admin/orders/order_history_paid', :controller => "admin/orders", :action => 'order_history_paid'
  map.admin '/admin/orders/order_history_cancelled', :controller => "admin/orders", :action => 'order_history_cancelled'

  map.admin '/admin/orders/cancelled_order', :controller => "admin/orders", :action => 'cancelled_order'
  map.admin '/admin/orders/accounting', :controller => "admin/orders", :action => 'accounting'
  map.admin '/admin/orders/order_history_accounting', :controller => "admin/orders", :action => 'order_history_accounting'
  map.admin '/admin/orders/approve_to_cancel', :controller=>"admin/orders", :action=>'approve_to_cancel'
  map.admin '/admin/orders/order_update', :controller=>"admin/orders", :action=>'order_update'
  map.admin '/admin/orders/approve_to_cancel_message', :controller=>"admin/orders", :action=>'approve_to_cancel_message'
  map.admin '/admin/orders/edit_travel_fee', :controller => "admin/orders", :action => 'edit_travel_fee'
  map.admin '/admin/orders/edit_total_revenue', :controller => "admin/orders", :action => 'edit_total_revenue'
  map.admin '/admin/orders/download', :controller => "admin/orders", :action => 'download'
  map.admin '/admin/executives/index', :controller => "admin/executives", :action => 'index'
  map.admin '/admin/executives', :controller => "admin/executives", :action => 'index'
  map.admin '/admin/executives/new', :controller => "admin/executives", :action => 'new'
  map.admin '/admin/executives/create', :controller => "admin/executives", :action => 'create'
  map.admin 'admin/clients/update_executive', :controller => "admin/clients", :action => 'update_executive'
  map.admin '/admin/clients/edit_customer_fee', :controller => "admin/clients", :action => 'edit_customer_fee'
  map.admin 'admin/orders/update_executive', :controller => "admin/orders", :action => 'update_executive'
  map.resource :session
  map.connect 'client/orders/:id/payment', :controller => 'client/orders', :action => 'payment'
  map.connect 'client/orders/:id/do_payment', :controller => 'client/orders', :action => 'do_payment'
  map.connect 'admin/orders/do_payment', :controller => 'admin/orders', :action => 'do_payment'
  map.connect 'admin/orders/make_payment', :controller => 'admin/orders', :action => 'make_payment'
  map.connect 'admin/orders/assign_notary/:order_id/:notary_id', :controller => 'admin/orders', :action => 'assign_notary', :order_id => :order_id, :notary_id => :notary_id
  map.connect 'client/orders/order_details/:order_id', :controller => 'client/orders', :action => 'order_detail'
  map.connect 'notary/orders/order_details/:order_id', :controller => 'notary/orders', :action => 'order_detail'
  map.admin '/admin/notaries/notary_details', :controller => "admin/notaries", :action => 'notary_details'
  map.connect 'admin/orders/order_details/:order_id', :controller => 'admin/orders', :action => 'order_detail', :order_id => :order_id
  map.connect 'admin/orders/create_feedback/:order_id', :controller => 'admin/orders', :action => 'create_feedback', :order_id => :order_id

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
