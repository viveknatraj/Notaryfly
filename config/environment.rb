# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.autoload_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  #config.time_zone = 'UTC'
  config.time_zone = 'Pacific Time (US & Canada)'

  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random,
  # no regular words or you'll be exposed to dictionary attacks.
  config.action_controller.session = {
      :session_key => '_notaryfly.com_session',
      :secret      => '9393157673a8f242fb2930d2b8ddab912a67a7f57be7cc0f28b9344b34096c391b643da4810aee69cb333702f0c8311cc8ed5cea366e3a22afd42057332795d1'
  }

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de

  config.gem "prawn", '0.6.3'
  config.gem 'will_paginate', '~> 2.3.11'	
  config.gem 'rdoc'
  config.gem "geokit", "~> 1.6.5"
  config.gem "geokit-rails", "~> 1.1.4"
  config.gem 'whenever', '0.9.2'
  config.gem 'pdfkit', '0.5.3'
  config.gem 'wkhtmltopdf-binary', '0.9.9.1'
end



#ActionMailer::Base.delivery_method = :smtp
##ActionMailer::Base.default_url_options = {:host => '122.183.217.155:3000'}
#ActionMailer::Base.smtp_settings = {
#  :enable_starttls_auto  => true,
#  :address               => 'smtp.gmail.com',
#  :port                  => 587,
#  :tls                   => true,
#  :domain                => 'gmail.com',
#  :authentication        => :plain,
#  :user_name		 => "durgaganeshtest@gmail.com",
#  :password		 => "123456test"
#}
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = false
ActionMailer::Base.default_charset = "utf-8"
ActionMailer::Base.default_content_type = "text/html"

#~ ActionMailer::Base.smtp_settings = {
#~ :address => "SMTP.emailsrvr.com",
#~ :domain => "notaryfly.com",
#~ :port => 587,
#~ :authentication => :login,
#~ :user_name => "noreply@notaryfly.com",
#~ :password => "12bheaney",
#~ }


ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :domain => "notaryfly.com",
    :port => 587,
    :authentication => :plain,
    :enable_starttls_auto => true,
    :user_name => "dckapdeveloper@gmail.com",
    :password => "developer@dckap-test1",
}
