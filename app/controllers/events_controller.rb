class EventsController < ApplicationController
  def switchify
    response.headers["Last-Modified"] = Time.now.httpdate
    @event = Event.find_by(meetup_id: params[:meetup_id])

    @switch = @event.switchify

    respond_to do |format|
      format.json { render :json => { "switch" => @switch }}
    end
  end

  def show
    response.headers["Last-Modified"] = Time.now.httpdate
    if user_signed_in?
      current_user.token_refresh
      @dashboard = current_user.dashboard
      @ongoing_event = @dashboard["ongoing_event"]
      #if @ongoing_event != nil
        # @ev_name = @ongoing_event["name"]
        # @ev_url = @ongoing_event["url"]
        # @ev_id = @ongoing_event["id"]
        # @ev_headcount = @ongoing_event["headcount"]
        # @ev_description = @ongoing_event["description"]

        respond_to do |format|
          format.json   { render :json => @ongoing_event.to_json }
          format.html
        end
      # else
        # flash[:error] = "Sorry, you don't have any ongoing meetup events at this time."
        # redirect_to root_path
      # end
    else
      flash[:error] = "Sorry, you must be logged in to an account to access this page."
      redirect_to root_path
    end
  end

  def mix
    response.headers["Last-Modified"] = Time.now.httpdate
    if user_signed_in?
      @event = Event.find_or_create_by(meetup_id: params[:meetup_id])
      if !current_user.in?(@event.users)
        @event.users.push(current_user)
      end
      if @event.batches.count == 0
        @event.batchify
      end

      @pairings = []
      @event.batches.last.pairings.each do |p|
        if p.users.count == 1
          @pairings << [p.users.first.meetup_uid]
        else
          @pairings << [p.users.first.meetup_uid, p.users.second.meetup_uid]
        end
      end
      respond_to do |format|
        format.json   { render :json => {:event => @event.as_json(:only => [:meetup_id]), :pairings => @pairings }}
      end
    else
      flash[:error] = "Sorry, you must be logged in to an account to access this page."
    end
  end

  def batchify
    @event = Event.find_by(meetup_id: params[:meetup_id])

    @event.batchify
    # redirect_to events_mix_path(@event.meetup_id)
  end

end
