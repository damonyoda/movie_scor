require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'Associations' do
    it { should belong_to(:movie) }
  end

  describe 'Validations' do
    let!(:movie1) { create(:movie) }

    it { should validate_inclusion_of(:stars).in_range(1..5) }
  end

  describe 'validates uniqueness of user within scope of movie_id' do
    let!(:movie1) { create(:movie) }
    let!(:review1) { create(:review, movie: movie1, stars: 4) }

    it 'does not allow duplicate reviews for the same user and movie' do
      duplicate_review = build(:review, movie: movie1, user: 'user1')
      expect(duplicate_review).not_to be_valid
    end
  end
end