class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations
  has_many :meetings, dependent: :destroy
  validates :name, :zipcode, :address, :district, presence: true
  validates :zipcode, length: { is: 5 }
  validates :address, length: { in: 6..100 }
  validates :district, length: { in: 5..40 }

  # geocoder
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address? # if address changes => geocode edits coord. accordingly
end
