class Location < ApplicationRecord
  has_many :users, through: :user_locations
  has_many :meetings, dependent: :destroy
  validates :name, :zipcode, :address, :district, presence: true
  validates :zipcode, length: { is: 5 }
  validates :address, length: { in: 6..100 }
  validates :district, length: { in: 6..40 }
end
