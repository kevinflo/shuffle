class AddMeetupTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_token, :string
  end
end
