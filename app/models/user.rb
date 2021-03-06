class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :user_locations
  has_many :locations, through: :user_locations
  has_many :copies, dependent: :destroy
  has_many :books, through: :copies
  has_many :handovers, as: :receiver
  has_many :handovers, as: :deliverer
end
