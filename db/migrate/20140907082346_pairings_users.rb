class PairingsUsers < ActiveRecord::Migration
  def change
    create_table :pairings_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :pairing, index: true
    end
  end
end