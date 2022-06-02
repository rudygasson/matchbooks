class Book < ApplicationRecord
  has_many :copies, dependent: :destroy
  has_many :users, through: :copies
  validates :isbn, :title, :author, :year, presence: true
  validates :isbn, length: { in: 10..13 }
  validates :isbn, uniqueness: true
  validates :year, length: { is: 4 }
  validates :description, length: { maximum: 3000 }
end
