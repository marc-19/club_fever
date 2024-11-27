class QuinielasController < ApplicationController
  before_action :set_club

  def new
    @quiniela = @club.quinielas.new
  end

  def create
    @quiniela = @club.quinielas.new(quiniela_params)
    if @quiniela.save
      redirect_to @club, notice: 'Quiniela was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def quiniela_params
    params.require(:quiniela).permit(:name)
  end
end
