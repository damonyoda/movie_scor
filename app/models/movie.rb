class Movie < ApplicationRecord
  has_many :movie_actor_locations
  has_many :actors, -> { distinct }, through: :movie_actor_locations
  has_many :locations, -> { distinct }, through: :movie_actor_locations
  has_many :reviews

  validates :name, presence: true
  validates :year, presence: true
  validates :name, uniqueness: { scope: :year, case_sensitive: false }

  def average_rating
    reviews.average(:stars)
  end
end
