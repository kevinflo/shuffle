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


  # def self.find_for_meetup_oauth(auth, signed_in_resource=nil)
  #   if user = User.where(:meetup_uid => auth.uid).first
  #     user.update_attributes(
  #       meetup_description:auth.info.description,
  #       meetup_image:auth.info.image,
  #       meetup_location:auth.info.location,
  #       meetup_name:auth.info.name,
  #       meetup_photo_url:auth.info.photo_url)
  #     user
  #   else
  #     user = User.create(meetup_uid:auth.uid,
  #       meetup_description:auth.info.description,
  #       meetup_image:auth.info.image,
  #       meetup_location:auth.info.location,
  #       meetup_name:auth.info.name,
  #       meetup_photo_url:auth.info.photo_url,
  #       password:Devise.friendly_token[0,20])
  #     user
  #   end
  # end

  def self.find_for_meetup_oauth(auth)
    where(meetup_uid: auth.uid).first_or_create do |user|
      # user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.meetup_name = auth.info.name   # assuming the user model has a name
      user.meetup_image = auth.info.image # assuming the user model has an image
      user.save!
    end
  end

end
