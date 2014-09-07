class AddMeetupInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :meetup_description, :string
    add_column :users, :meetup_image, :string
    add_column :users, :meetup_location, :string
    add_column :users, :meetup_name, :string
    add_column :users, :meetup_photo_url, :string
  end
end
