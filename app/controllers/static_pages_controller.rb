class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @dashboard = current_user.dashboard.to_json
    end
  end
end
