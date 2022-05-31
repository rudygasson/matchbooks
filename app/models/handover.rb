class Handover < ApplicationRecord
  enum :status, %i[pending cancelled confirmed]
  belongs_to :meeting
  belongs_to :copy
  belongs_to :receiver
  belongs_to :deliverer
end
