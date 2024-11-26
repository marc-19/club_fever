class PredictionsController < ApplicationController
  def new
    @quiniela = Quiniela.find(params[:quiniela_id])
    @local_teams = @quiniela.local_teams
    @visitor_teams = @quiniela.visitor_teams
    @prediction = Prediction.new
  end

  def create
    @quiniela = Quiniela.find(params[:quiniela_id])
    @prediction = current_user.predictions.new(prediction_params)
    @prediction.quiniela = @quiniela

    if @prediction.save
      redirect_to quinielas_path, notice: "Your prediction has been submitted!"
    else
      flash.now[:alert] = "There was an error submitting your prediction."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prediction_params
    params.require(:prediction).permit(result: [])
  end
end

