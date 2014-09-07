class AddMeetupRefreshTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_refresh_token, :string
  end
end
