class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:meetup]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :pairings
  has_and_belongs_to_many :events


  def email_required?
    false
  end
  
  def email_changed?
    false
  end

  def self.find_for_meetup_oauth(auth)
    where(meetup_uid: auth.uid).first_or_create do |user|
      # user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.meetup_name = auth.info.name   # assuming the user model has a name
      user.meetup_image = auth.info.image # assuming the user model has an image
      user.meetup_token = auth.credentials.token
      user.meetup_refresh_token = auth.credentials.refresh_token
      user.save!
    end
  end

  def dashboard
    dash = HTTParty.get("https://api.meetup.com/dashboard", :headers => { "Authorization" => "bearer #{self.meetup_token}"})
    dash
  end

  def token_refresh
    fresh = HTTParty.post("https://secure.meetup.com/oauth2/access", :body => { "client_id" => Rails.application.secrets.meetup_oauth_key,
"client_secret" => Rails.application.secrets.meetup_oauth_secret, 
"grant_type" => "refresh_token",
"refresh_token" => self.meetup_refresh_token }, :headers => { "Content-Type" => "application/x-www-form-urlencoded" })

    self.update(meetup_refresh_token:fresh["refresh_token"], meetup_token:fresh["access_token"])
  end

end
