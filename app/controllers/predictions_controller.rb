class PredictionsController < ApplicationController
  def new
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams
    @prediction = Prediction.new
  end

  def create
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams
    @prediction = current_user.predictions.new(prediction_params)

    # Extract and assign the result array
    @prediction.result = params[:prediction][:result].values
    @prediction.quiniela = @quiniela

    if @prediction.save
      redirect_to home_path, notice: "Your prediction has been submitted!"
    else
      flash.now[:alert] = "There was an error submitting your prediction."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prediction_params
    params.require(:prediction).permit(result: []) # Permit an array of results
  end

  def set_teams
    # Clean the local and visitor teams arrays
    @local_teams = @quiniela.local_teams.map(&:strip)
    @visitor_teams = @quiniela.visitor_teams.map(&:strip)
  end
end
