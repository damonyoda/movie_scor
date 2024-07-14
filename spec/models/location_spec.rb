require 'rails_helper'
RSpec.describe Location, type: :model do
  describe 'Associations' do
    it { should have_many(:movie_actor_locations) }
    it { should have_many(:movies).through(:movie_actor_locations) }
  end

  describe 'Validations' do
    let!(:location) { create(:location) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:country).case_insensitive }
  end
end