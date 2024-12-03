class PredictionsController < ApplicationController
  before_action :set_quiniela
  before_action :set_teams, except: [:show]

  def show
    @prediction = Prediction.find(params[:id])
    @quiniela = @prediction.quiniela
    @local_teams = @quiniela.local_teams.map(&:strip)
    @visitor_teams = @quiniela.visitor_teams.map(&:strip)
  end

  def new
    @prediction = Prediction.new

    # Load predictions from session if present
    if session[:results].present?
      @prediction.result = session.delete(:results)
    end
  end

  def create
    if current_user.nil?
      # Save selected predictions in session
      session[:results] = params[:prediction][:result].values
      session[:return_to] = new_quiniela_prediction_path(@quiniela)
      redirect_to new_user_session_path, alert: "Please log in to submit your prediction."
      return
    end

    existing_prediction = current_user.predictions.find_by(quiniela: @quiniela)
    if existing_prediction
      redirect_to club_path(@quiniela.club), alert: "You have already submitted a prediction for this quiniela."
    else
      # Create a new prediction
      @prediction = current_user.predictions.new(prediction_params)
      @prediction.result = params[:prediction][:result].values # Assign result array
      @prediction.quiniela = @quiniela # need this?

      if @prediction.save
        session.delete(:results)
        redirect_to user_path(current_user, confirmation: true, quiniela_id: @quiniela.id)
      else
        flash.now[:alert] = "There was an error submitting your prediction."
        render :new, status: :unprocessable_entity
      end
    end
  end

  private

  def set_quiniela
    @quiniela = Quiniela.find(params[:quiniela_id])
  end

  def prediction_params
    params.require(:prediction).permit(result: []) # Permit an array of results
  end

  def set_teams
    @local_teams = @quiniela.local_teams.map(&:strip)
    @visitor_teams = @quiniela.visitor_teams.map(&:strip)
  end
end
