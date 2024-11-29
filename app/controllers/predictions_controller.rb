class PredictionsController < ApplicationController
  def new
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams

    @prediction = Prediction.new
    if session[:results].present?
      @prediction.result = session[:results]
    end
  end

  def create
    @quiniela = Quiniela.find(params[:quiniela_id])
    set_teams

    if current_user.nil?
      session[:results] = params[:prediction][:result].values
      session[:return_to] =  new_quiniela_prediction_path
      redirect_to new_user_session_path, alert: 'Please sign in to submit your prediction.'
      return
    end

    existing_prediction = current_user.predictions.find_by(quiniela: @quiniela)
    if existing_prediction
      redirect_to quiniela_path(@quiniela), alert: "You have already submitted a prediction for this quiniela."
      return
    end

    @prediction = @quiniela.predictions.new(prediction_params)
    @prediction.user = current_user
    @prediction.result = params[:prediction][:result].values
    @prediction.quiniela = @quiniela

    if @prediction.save
      session.delete(:results)
      redirect_to user_path(current_user), notice: "Your prediction has been submitted!"
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
