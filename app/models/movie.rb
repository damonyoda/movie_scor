class Movie < ApplicationRecord

  validates :name, presence: true
  validates :year, presence: true
  validates :name, uniqueness: { scope: :year, case_sensitive: false }
end
