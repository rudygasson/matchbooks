class Copy < ApplicationRecord
  belongs_to :user
  belongs_to :book
  has_many :handovers, dependent: :destroy
end
