class Event < ActiveRecord::Base
  has_many :batches
  has_and_belongs_to_many :users
end
