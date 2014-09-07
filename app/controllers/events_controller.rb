class EventsController < ApplicationController
  def show
    if user_signed_in?
      if Time.now - current_user.updated_at >= 3600
        current_user.token_refresh
      end
      @dashboard = current_user.dashboard
      @ongoing_event = @dashboard["ongoing_event"]
      # @ev_name = @ongoing_event["name"]
      # @ev_url = @ongoing_event["url"]
      # @ev_id = @ongoing_event["id"]
      # @ev_headcount = @ongoing_event["headcount"]
      # @ev_description = @ongoing_event["description"]

      respond_to do |format|
        format.json   { render :json => @ongoing_event.to_json }
        format.html
      end
    else
      flash[:error] = "Sorry, you must be logged in to an account to access this page."
      redirect_to root_path
    end
  end
end
