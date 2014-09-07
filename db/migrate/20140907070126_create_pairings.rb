class CreatePairings < ActiveRecord::Migration
  def change
    create_table :pairings do |t|
      t.belongs_to :batch

      t.timestamps
    end
  end
end
