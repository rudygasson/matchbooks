class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates_uniqueness_of :location_id, { scope: :user_id }
end
