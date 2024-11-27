class ClubsController < ApplicationController
  def index
    @clubs = Club.all
    query = params[:query]
    @clubs = Club.where("name ILIKE ?", "%#{query}%")
  end

  def show
    @club = Club.find(params[:id])
    @quinielas = @club.quinielas 
  end
end
