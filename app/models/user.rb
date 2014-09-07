class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:meetup]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

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

end
