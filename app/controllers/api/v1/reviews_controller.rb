class Api::V1::ReviewsController < ApplicationController
  def index
    @movie = Movie.find_by(id: params[:movie_id])
    render json: @movie&.reviews
  end

  def show
    @review = Review.find_by(id: params[:id])
    render json: @review
  end
end
