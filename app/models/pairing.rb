class Pairing < ActiveRecord::Base
  belongs_to :batch, dependent: :destroy
  has_and_belongs_to_many :users
end
