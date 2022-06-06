class Meeting < ApplicationRecord
  validates :date, :time, presence: true
  enum :status, %i[pending cancelled confirmed], default: :pending
  belongs_to :location
  has_many :handovers, dependent: :destroy
  has_one :chatroom, dependent: :destroy
end
