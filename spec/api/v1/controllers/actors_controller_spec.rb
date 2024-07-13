require 'rails_helper'

RSpec.describe Api::V1::ActorsController, type: :controller do
  let!(:movie1) { create(:movie) }
  let!(:movie2) { create(:movie) }
  let!(:actor1) { create(:actor, name: 'Johnny Depp') }
  let!(:actor2) { create(:actor, name: 'Tom Cruise') }
  let!(:location1) { create(:location) }
  let!(:location2) { create(:location) }
  let!(:review1) { create(:review, movie: movie1, stars: 4) }
  let!(:review2) { create(:review, movie: movie2, stars: 5) }

  let!(:movie_actor_location1) { create(:movie_actor_location, movie: movie1, actor: actor1, location: location1) }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns actors order by name' do
      get :index

      expect(response).to be_successful
      expect(assigns(:actors)).to eq([actor1, actor2])
    end

  end

  describe 'GET #show' do
    it 'returns the actor by id' do
      get :show, params: { id: actor1.id }

      expect(response).to be_successful
      expect(assigns(:actor)).to eq(actor1)
    end

    it 'returns null when not found' do
      get :show, params: { id: 100 }

      expect(response).to be_successful
      expect(response.body).to eq('null')
    end
  end

  describe 'GET #search' do
    context 'when actor is found' do
      before do
        get :search, params: { name: "Depp" }
      end

      it 'returns a successful response' do
        expect(response).to have_http_status(:success)
      end

      it 'returns movies when actor is found' do
        get :search, params: { actor: actor1.name }
        expect(response).to have_http_status(:success)
        expect(response.body).to include(movie1.name)
      end

      it 'returns movies associated with the actor' do
        expect(response.body).to include(movie1.name)
        expect(response.body).not_to include(movie2.name)
      end

    end

    context 'when actor is not found' do
      before do
        get :search, params: { name: 'nonexistent' }
      end

      it 'returns a successful response' do
        expect(assigns(:actor)).to eq([])
        expect(response).to have_http_status(:success)
      end
    end
  end

end
