class AddMeetupTokenExpiresAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_token_expires_at, :integer
  end
end
