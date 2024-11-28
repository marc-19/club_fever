class QuinielasController < ApplicationController
  before_action :set_club
  before_action :set_quiniela, only: [:edit, :update]

  def new
    @quiniela = @club.quinielas.new
  end

  def create
    @quiniela = @club.quinielas.new(quiniela_params)
     Rails.logger.debug "Quiniela Params: #{quiniela_params.inspect}"

    if valid_matches?(@quiniela.local_teams, @quiniela.visitor_teams) && @quiniela.save
      render plain: "Quiniela was successfully created."
    else
      flash.now[:alert] = "Please provide exactly 10 matches with local and visitor teams."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @local_teams = @quiniela.local_teams
    @visitor_teams = @quiniela.visitor_teams
  end

  def update
    @quiniela.result = params[:quiniela][:result].values # assign result array to quiniela result

    if @quiniela.save
      redirect_to club_path(@club), notice: "Quiniela results have been successfully updated."
    else
      flash.now[:alert] = "There was an error updating the quiniela results."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def set_quiniela
    @quiniela = @club.quinielas.find(params[:id])
  end

  def quiniela_params
    params.require(:quiniela).permit(
      :title,
      :reward,
      :start_date,
      :end_date,
      local_teams: [],
      visitor_teams: [],
      result: []
    )
  end

  def valid_matches?(local_teams, visitor_teams)
    local_teams.size == 10 && visitor_teams.size == 10
  end
end
