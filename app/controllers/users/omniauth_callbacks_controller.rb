class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def meetup
    @user = User.find_for_meetup_oauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.meetup_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to new_user_registration_url
    end

    # puts "froop7"
    # puts request.env["omniauth.auth"].uid

    # puts
    # puts request.env["omniauth.auth"].info
    # puts
    # puts request.env["omniauth.auth"].credentials
    # puts
    # puts request.env["omniauth.auth"].extra

    # puts request.env["omniauth.auth"].info.name

  end

  # def facebook
  #   @user = User.find_for_facebook_oauth(request.env["omniauth.auth"])

  #   if @user.persisted?
  #     sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
  #     set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
  #   else
  #     session["devise.facebook_data"] = request.env["omniauth.auth"].except("extra")
  #     redirect_to new_user_registration_url
  #   end
  # end

  # def stripe_connect
  #   @user = User.find_for_stripe_oauth(request.env["omniauth.auth"], current_user)

  #   if @user.persisted?
  #     set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
  #     redirect_to board_ticketed_path(@user.boards.first)
  #   else
  #     flash[:error] = "Please create a Showboarder account before connecting with Stripe."
  #     redirect_to new_user_registration_url
  #   end

    # raise request.env["omniauth.auth"].to_yaml
  # end  
end