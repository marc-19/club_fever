class ClubsController < ApplicationController

  def index
    @clubs = Club.all
    query = params[:query]
    @clubs = Club.where("name ILIKE ?", "%#{query}%")
  end
  
  def show
    @club = Club.find(params[:id])
    @quinielas = @club.quinielas
    @active_quinielas = @club.quinielas.where("start_date > ?", DateTime.now)
    @past_quinielas = @club.quinielas.where("end_date < ?", DateTime.now)
  end
end
