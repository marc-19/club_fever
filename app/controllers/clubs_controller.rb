class ClubsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_club, only: [:show, :edit, :update]
  before_action :authorize_admin, only: [:edit, :update]

  def authorize_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.is_admin?
  end

  def index
    @clubs = Club.all
    query = params[:query]
    @clubs = Club.where("name ILIKE ?", "%#{query}%")
  end

  def show
    @active_quinielas = @club.quinielas.where("start_date > ?", DateTime.now)
    @past_quinielas = @club.quinielas.where("end_date < ?", DateTime.now)
  end

  def edit
  end

  def update
    if @club.update(club_params)
      redirect_to @club, notice: "Club details updated successfully!"
    else
      flash.now[:alert] = "Failed to update club details."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def authorize_admin
    unless current_user == @club.user
      redirect_to root_path, alert: "Not authorized to edit this club."
    end
  end

  def club_params
    params.require(:club).permit(:name, :description, :logo, :header_img)
  end
end
