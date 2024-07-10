class Location < ApplicationRecord
  validates :name, presence: true
  validates :name, presence: true
  validates :name, uniqueness: { scope: :country, case_sensitive: false }
end
