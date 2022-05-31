class Location < ApplicationRecord
  has_many :users, through: :user_locations
end
