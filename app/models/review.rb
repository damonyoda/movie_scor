class Review < ApplicationRecord
  belongs_to :movie

  validates :stars, inclusion: { in: 1..5 }
end
