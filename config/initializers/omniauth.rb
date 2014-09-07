Rails.application.config.middleware.use OmniAuth::Builder do
  provider :meetup, Rails.application.secrets.meetup_oauth_key, Rails.application.secrets.meetup_oauth_secret
end