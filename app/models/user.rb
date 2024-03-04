class User < ApplicationRecord
  has_secure_password
  has_many :user_movies
  has_many :movies, through: :user_movies

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
