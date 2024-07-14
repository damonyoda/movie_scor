require 'rails_helper'
RSpec.describe Actor, type: :model do
  describe 'Associations' do
    it { should have_many(:movie_actor_locations) }
    it { should have_many(:movies).through(:movie_actor_locations) }
  end

  describe "Validations" do
    let(:actor1) { create(:actor) }
    
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end