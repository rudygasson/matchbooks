class UserLocation < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :location, dependent: :destroy
end
