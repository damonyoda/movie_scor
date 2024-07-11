class MovieActorLocation < ApplicationRecord
  belongs_to :movie
  belongs_to :actor
  belongs_to :location

  validates :movie_id, uniqueness: { scope: [:actor_id, :location_id] }
end
