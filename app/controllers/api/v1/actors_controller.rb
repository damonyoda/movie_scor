class Api::V1::ActorsController < ApplicationController
  def index
    @actors = Actor.all.order(:name)
    render json: @actors, include: [:movies]
  end

  def show
    @actor = Actor.find_by(id: params[:id])
    render json: @actor, include: [:movies]
  end

  def search
    @actor = Actor.where("name ILIKE ?", "%#{params[:name]}%").order(:name)
    render json: @actor, include: [:movies]
  end
end
