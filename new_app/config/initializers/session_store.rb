# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_new_app_session',
  :secret      => 'd09fd78b08ce80454fc9b1bba0d6cd6f567363003dfb72ca4c1187b4e2681bbaf6314a2b0c5ace9d099c9991a0552006cd798473bb238825af06ea74ce0e7ea9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
