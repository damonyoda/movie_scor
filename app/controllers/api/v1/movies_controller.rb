class Api::V1::MoviesController < ApplicationController
  def index
    sort = params[:sort]&.downcase == 'asc' ? 'ASC' : 'DESC'

    @movies = Movie.left_joins(:reviews)
              .includes(:actors, :locations)
              .group('movies.id')
              .select('movies.*, AVG(reviews.stars) as average_rating')
              .order(Arel.sql("AVG(reviews.stars) DESC NULLS LAST"))

    render json: @movies, include: [:actors, :locations]
  end

  def show
    @movie = Movie.includes(:reviews, :actors, :locations).find_by(id: params[:id])
    render json: @movie, include: [:actors, :locations]
  end

  def search
    @actor = Actor.find_by("name ILIKE ?", "%#{params[:actor]}%")
    @movies = @actor ? @actor.movies : []
    render json: @movies, include: [:actors, :locations]
  end
end
