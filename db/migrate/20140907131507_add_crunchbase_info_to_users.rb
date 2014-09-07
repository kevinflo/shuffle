class AddCrunchbaseInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :c_name, :string
    add_column :users, :c_short_description, :string
    add_column :users, :c_permalink, :string
    add_column :users, :c_homepage_url, :string
  end
end
