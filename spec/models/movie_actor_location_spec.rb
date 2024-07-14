require 'rails_helper'

RSpec.describe MovieActorLocation, type: :model do
  describe 'Associations' do
    it { should belong_to(:movie) }
    it { should belong_to(:actor) }
    it { should belong_to(:location) }
  end

  describe 'Validations' do
    let!(:movie1) { create(:movie) }
    let!(:actor1) { create(:actor) }
    let!(:location1) { create(:location) }
    let!(:movie_actor_location1) { create(:movie_actor_location, movie: movie1, actor: actor1, location: location1) }

    it { should validate_uniqueness_of(:movie_id).scoped_to(:actor_id, :location_id) }
  end
end
