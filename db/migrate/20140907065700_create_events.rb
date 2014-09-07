class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :meetup_id
      t.integer :active

      t.timestamps
    end
  end
end
