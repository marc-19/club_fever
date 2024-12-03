class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
    @past_predictions = @user.predictions.includes(:quiniela)

    @quiniela = Quiniela.find_by(id: params[:quiniela_id])

  end
end
