class ClubsController < ApplicationController
  def index
    if params[:search].present?
      query = params[:search][:search] # Acessa o campo da busca dentro do form
      @clubs = Club.where('name ILIKE ?', "%#{query}%") # Busca insensível a maiúsculas/minúsculas
    else
      @clubs = Club.all # Mostra todos os clubes se a busca estiver vazia
    end
  end
end

def all
  @clubs = Club.all
end
