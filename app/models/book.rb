class Book < ApplicationRecord
  has_many :copies
  validates :isbn, :title, :author, :year, presence: true
  validates :isbn, length: { in: 10..13 }
  validates :year, length: { is: 4 }
  validates :description, length: { maximum: 500 }
end
