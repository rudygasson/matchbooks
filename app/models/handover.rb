class Handover < ApplicationRecord
  enum :status, %i[pending cancelled confirmed], default: :pending
  belongs_to :meeting
  belongs_to :copy
  belongs_to :receiver, class_name: "User"
  belongs_to :deliverer, class_name: "User"
end
