class UsersController < ApplicationController

  def update
    current_user.update(email: params[:email], c_name: params[:name], c_short_description: params[:short_description], c_permalink: params[:permalink], c_homepage_url: params[:homepage_url])
  end

  def csearch
    @query = params[:query]

    full_response = HTTParty.get("http://api.crunchbase.com/v/2/organizations?query=#{@query}&user_key=#{Rails.application.secrets.crunchbase_key}&page=1")

    path = full_response["data"]["items"][0]["path"]

    cdata = HTTParty.get("http://api.crunchbase.com/v/2/#{path}?user_key=3168e8bc0bbadc333b77a33e251bcb8f")

    selected = { "name" => cdata["data"]["properties"]["name"], "short_description" => cdata["data"]["properties"]["short_description"], "permalink" => cdata["data"]["properties"]["permalink"], "homepage_url" => cdata["data"]["properties"]["homepage_url"]  }

    puts selected

    respond_to do |format|
      format.json   { render :json => selected}
    end
  end

  def show
    @user = User.find_by(meetup_uid: params[:meetup_uid])

    respond_to do |format|
        format.json   { render :json => @user.as_json(:only => [:meetup_uid, :meetup_name, :meetup_image]) }
      end
  end
end
