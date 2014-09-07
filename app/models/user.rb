class User < ActiveRecord::Base

  def self.find_for_meetup_oauth(auth, signed_in_resource=nil)
    if user = User.where(:email => auth.uid).first
      user.update_attributes(
        meetup_description:auth.info.description,
        meetup_image:auth.info.image,
        meetup_location:auth.info.location,
        meetup_name:auth.info.name,
        meetup_photo_url:auth.info.photo_url)
      user
    else
      user = User.create(meetup_uid:auth.uid,
        meetup_description:auth.info.description,
        meetup_image:auth.info.image,
        meetup_location:auth.info.location,
        meetup_name:auth.info.name,
        meetup_photo_url:auth.info.photo_url,
        password:Devise.friendly_token[0,20])
      user
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:meetup]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
