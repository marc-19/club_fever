class UsersController < ApplicationController
  before_action :authenticate_user! # Garante que o usuário esteja logado

  def show
    @user = User.find(params[:id])
    # Verifica se o usuário atual é o dono do perfil
    if @user != current_user
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
    @past_predictions = @user.predictions.includes(:quiniela)

    @active_quinielas = [] 
    @done_quinielas = []
    @past_quinielas = []
  end
end
