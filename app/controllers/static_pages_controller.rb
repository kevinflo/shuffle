class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @dashboard = current_user.dashboard.to_json
      @current_user = current_user.to_json
      render "ang"
    end
  end
end
