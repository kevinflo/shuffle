class EventsController < ApplicationController
  def show
    if user_signed_in?
      if Time.now - current_user.updated_at >= 3600
        current_user.token_refresh
      end
      @dashboard = current_user.dashboard
      @ongoing_event = @dashboard["ongoing_event"]
      if @ongoing_event != nil
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
        flash[:error] = "Sorry, you don't have any ongoing meetup events at this time."
        redirect_to root_path
      end
    else
      flash[:error] = "Sorry, you must be logged in to an account to access this page."
      redirect_to root_path
    end
  end

  def mix
    if user_signed_in?
      @event = Event.find_or_create_by(params[:meetup_id])
      if !current_user.in?(@event)
        @event.users.push(current_user)
      end
      respond_to do |format|
        format.json   { render :json => @event }
      end
    else
      flash[:error] = "Sorry, you must be logged in to an account to access this page."
      redirect_to root_path
    end
  end
end
