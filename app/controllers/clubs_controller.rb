class ClubsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_club, only: [:show, :edit, :update, :follow, :unfollow]
  before_action :authorize_admin, only: [:edit, :update]

  def new
    @club = Club.new
  end

  def create
    @club = current_user.clubs.build(club_params)
    if @club.save
      redirect_to club_path(@club), notice: "Club created successfully!"
    else
      flash.now[:alert] = @club.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    if params[:search].present?
      query = params[:search][:search] # Acessa o campo da busca dentro do form
      @clubs = Club.where('name ILIKE ?', "%#{query}%") # Busca insensível a maiúsculas/minúsculas
    else
      @clubs = Club.all # Mostra todos os clubes se a busca estiver vazia
    end
  end

  def show
    @quinielas = @club.quinielas
    @active_quinielas = @club.quinielas.where("end_date >= ?", DateTime.now)
    @past_quinielas = @club.quinielas.where("end_date < ?", DateTime.now)
  end

  def edit
    @club = current_user.clubs.find(params[:id])
    @resolved_quinielas = @club.quinielas
                                .where("array_length(result, 1) > 0")
                                .order(end_date: :desc)
                                .limit(5)
  end

  def update
    if @club.update(club_params)
      redirect_to @club, notice: "Club details updated successfully!"
    else
      flash.now[:alert] = "Failed to update club details."
      render :edit, status: :unprocessable_entity
    end
  end

  def follow
    current_user.followed_clubs << @club
    redirect_to @club, notice: "You are now following #{@club.name}!"
  rescue ActiveRecord::RecordInvalid
    redirect_to @club, alert: "You are already following this club."
  end

  def unfollow
    current_user.followed_clubs.destroy(@club)
    redirect_to @club, notice: "You have unfollowed #{@club.name}."
  end

  private

  def set_club
    if params[:id]
      @club = Club.find(params[:id])
    end
  end

  def authorize_admin
    unless current_user == @club.user
      redirect_to club_path(@club), alert: "You are not authorized to edit this club."
    end
  end

  def club_params
    params.require(:club).permit(:name, :description, :logo, :header_img)
  end
end

def all
  @clubs = Club.all
end
