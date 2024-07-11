class Api::V1::MoviesController < ApplicationController
  def index
    @movies = Movie.includes(:actors, :locations)
                       .group('movies.id')

    render json: @movies, include: [:actors, :locations]
  end

  def show
    @movie = Movie.includes(:actors, :locations).find_by(id: params[:id])
    render json: @movie, include: [:actors, :locations]
  end

  def search
    @actor = Actor.find_by("name ILIKE ?", "%#{params[:actor]}%")
    @movies = @actor ? @actor.movies : []
    render json: @movies, include: [:actors, :locations]
  end
end
