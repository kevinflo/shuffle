class Batch < ActiveRecord::Base
  belongs_to :event, dependent: :destroy
  has_many :pairings
end
