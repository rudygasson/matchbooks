class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates_uniqueness_of :location, { scope: :user }
end
