require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { should have_many(:movie_actor_locations) }
    it { should have_many(:actors).through(:movie_actor_locations) }
    it { should have_many(:locations).through(:movie_actor_locations) }
    it { should have_many(:reviews) }
  end

  describe 'validations' do
    subject { build(:movie) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:year) }
    it { should validate_uniqueness_of(:name).scoped_to(:year).case_insensitive }
  end

  describe '#average_rating' do
    let(:movie1) { create(:movie) }
    
    it 'returns average rating of reviews' do
      create(:review, movie: movie1, stars: 3)
      create(:review, movie: movie1, stars: 4)
      expect(movie1.average_rating).to eq(3.5)
    end

    it 'returns nil when there are no reviews' do
      expect(movie1.average_rating).to be_nil
    end
  end
end