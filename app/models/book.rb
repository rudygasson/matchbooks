class Book < ApplicationRecord
  has_many :copies, dependent: :destroy
  has_many :users, through: :copies
  has_many :locations, through: :users
  validates :isbn, :title, :author, :year, presence: true
  validates :isbn, length: { in: 10..13 }
  validates :isbn, uniqueness: true
  validates :year, length: { is: 4 }
  validates :description, length: { maximum: 3000 }

  scope :with_title_or_author, -> (search_term) {
    sql_query = "title LIKE :query OR author LIKE :query"
    where(sql_query, query: "%#{search_term}%")
  }
  scope :in_area, -> (area, all_areas) {
    return all if area == all_areas
    where(locations: {district: area}).includes(:locations)
  }
end
