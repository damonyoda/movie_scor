class Location < ApplicationRecord
  has_many :movie_actor_locations
  has_many :movies, -> { distinct }, through: :movie_actor_locations

  validates :name, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :country, case_sensitive: false }
end
