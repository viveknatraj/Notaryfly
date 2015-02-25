# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_notaryflynew_session',
  :secret      => 'a9a14267149cca1cc56af8af902312245b418e2a864e1ba70d476fc99e843ca6cad5ab98a0f1aed0a60f942fa8a82131949dff946f30c6b2f83b59d5ce87f017'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
