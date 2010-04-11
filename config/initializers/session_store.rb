# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_be-on-the-same-list-rails_session',
  :secret      => '9ec18703aa67389bbdb5275e286d4aea1fe2facc1a751fb826149b686ab35f64dda35214ad438a7ad1e1a166a60fc3e50688237456b0ff238bdc79ee5719e64b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
