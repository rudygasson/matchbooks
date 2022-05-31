class Meeting < ApplicationRecord
  enum :status, [ :pending, :cancelled, :confirmed ]
  belongs_to :location
end
