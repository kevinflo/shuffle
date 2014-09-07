class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @dashboard = current_user.dashboard.to_json
      # @ongoing_event = dashboard["ongoing_event"]
      # @ev_name = @ongoing_event["name"]
      # @ev_url = @ongoing_event["url"]
      # @ev_id = @ongoing_event["id"]
      # @ev_headcount = @ongoing_event["headcount"]
      # @ev_description = @ongoing_event["description"]
    end
  end
end
