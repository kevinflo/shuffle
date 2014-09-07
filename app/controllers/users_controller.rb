class UsersController < ApplicationController
  def show
    @user = User.find_by(meetup_uid: params[:meetup_uid])

    respond_to do |format|
        format.json   { render :json => @user.as_json(:only => [:meetup_uid, :meetup_name, :meetup_image]) }
      end
  end
end
