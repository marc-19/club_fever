class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to access this page."
    end

    @quiniela = Quiniela.find_by(id: params[:quiniela_id])
    @past_predictions = @user.predictions.includes(:quiniela)
    @playable_quinielas = current_user.followed_clubs.includes(:quinielas).flat_map do |club|
      club.quinielas.playable.reject { |quiniela| @past_predictions.map(&:quiniela_id).include?(quiniela.id) }
    end
  end
end
