class QuinielasController < ApplicationController
  before_action :set_club

  def new
    @quiniela = @club.quinielas.new
  end

  def create
    @quiniela = @club.quinielas.new(quiniela_params)
     Rails.logger.debug "Quiniela Params: #{quiniela_params.inspect}"

    if valid_matches?(@quiniela.local_teams, @quiniela.visitor_teams) && @quiniela.save
      redirect_to club_path(@club), notice: "Quiniela was successfully created!"
    else
      flash.now[:alert] = "Please provide exactly 10 matches with local and visitor teams."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def quiniela_params
    params.require(:quiniela).permit(
      :title,
      :reward,
      :start_date,
      :end_date,
      local_teams: [],
      visitor_teams: []
    )
  end

  def valid_matches?(local_teams, visitor_teams)
    local_teams.size == 10 && visitor_teams.size == 10
  end
end
