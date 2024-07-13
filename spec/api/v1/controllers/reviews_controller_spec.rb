require 'rails_helper'

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let!(:movie1) { create(:movie) }
  let!(:movie2) { create(:movie) }
  let!(:review1) { create(:review, movie: movie1, stars: 4, review: "Great") }
  let!(:review2) { create(:review, movie: movie2, stars: 5, review: "Best") }

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { movie_id: movie1.id }
      expect(response).to have_http_status(:success)
    end

    it 'returns reviews associated with the movie' do
      get :index, params: { movie_id: movie1.id }
      expect(response).to be_successful
      
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(1) 
      expect(json_response[0]['stars']).to eq(review1.stars)
    end

    it 'returns empty array if movie has no reviews' do
      movie_without_reviews = create(:movie)

      get :index, params: { movie_id: movie_without_reviews.id }
      expect(response).to be_successful
      
      json_response = JSON.parse(response.body)
      expect(json_response).to be_empty
    end

    it 'returns null when not found' do
      get :index, params: { movie_id: 100 }

      expect(response).to be_successful
      expect(response.body).to eq('null')
    end
  end

  describe 'GET #show' do
    it 'returns the review by id' do
      get :show, params: { movie_id: movie1.id, id: review1.id }

      expect(response).to be_successful
      expect(assigns(:review)).to eq(review1)
    end

    it 'returns null when not found' do
      get :show, params: { movie_id: movie1.id, id: 100 }

      expect(response).to be_successful
      expect(response.body).to eq('null')
    end
  end
end
