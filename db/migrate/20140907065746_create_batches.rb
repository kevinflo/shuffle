class CreateBatches < ActiveRecord::Migration
  def change
    create_table :batches do |t|
      t.belongs_to :event, index: true

      t.timestamps
    end
  end
end
