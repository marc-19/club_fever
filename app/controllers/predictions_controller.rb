class PredictionsController < ApplicationController
  def new
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams
    @prediction = Prediction.new
  end

  def create
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams

    # Check if the user already has a prediction for this quiniela
    existing_prediction = current_user.predictions.find_by(quiniela: @quiniela)

    if existing_prediction
      redirect_to quiniela_path(@quiniela), alert: "You have already submitted a prediction for this quiniela."
    else
      # Create a new prediction
      @prediction = current_user.predictions.new(prediction_params)
      @prediction.result = params[:prediction][:result].values # Assign result array
      @prediction.quiniela = @quiniela # need this?

      if @prediction.save
        redirect_to user_path(current_user), notice: "Your prediction has been submitted!"
      else
        flash.now[:alert] = "There was an error submitting your prediction."
        render :new, status: :unprocessable_entity
      end
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

