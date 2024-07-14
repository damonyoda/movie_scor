class Review < ApplicationRecord
  belongs_to :movie

  validates :user, uniqueness: { scope: :movie_id }
  validates :stars, inclusion: { in: 1..5 }
end
