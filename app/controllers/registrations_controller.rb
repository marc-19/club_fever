class RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new(is_admin: false) # Default to regular user
    super
  end

  def new_admin
    @user = User.new(is_admin: true) # Default to admin user
    render :new_admin # Render a custom view
  end

  def create_admin
    @user = User.new(user_params)
    @user.is_admin = true # Ensure this user is an admin

    if @user.save
      sign_in(@user)
      redirect_to new_club_path, notice: "Welcome, please create your club!"
    else
      render :new_admin, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :phone_number)
  end
end
