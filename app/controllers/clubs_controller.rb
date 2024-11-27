class ClubsController < ApplicationController

  def index
    if params[:search].present?
      query = params[:search][:search] # Acessa o campo da busca dentro do form
      @clubs = Club.where('name ILIKE ?', "%#{query}%") # Busca insensível a maiúsculas/minúsculas
    else
      @clubs = [] # Mostra todos os clubes se a busca estiver vazia
    end
  end

  def show
    @club = Club.find(params[:id])
    @active_quinielas = @club.quinielas.where("start_date > ?", DateTime.now)
    @past_quinielas = @club.quinielas.where("end_date < ?", DateTime.now)
  end
end

def all
  @clubs = Club.all
end
