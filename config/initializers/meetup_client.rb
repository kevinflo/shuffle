MeetupClient.configure do |config|
  config.api_key = Rails.application.secrets.meetup_key
end