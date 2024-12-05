class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Custom 'new' action for regular users
  def new
    @user = User.new(is_admin: false) # Default to regular user
    super
  end

  # Custom 'new_admin' action
  def new_admin
    @user = User.new(is_admin: true) # Default to admin user
    render :new_admin # Render a custom view
  end

  def edit
    super
  end

  # Custom 'create_admin' action
  def create_admin
    @user = User.new(user_params) # Adicionando user_params aqui
    @user.is_admin = true # Ensure this user is an admin

    if @user.save
      sign_in(@user)
      redirect_to new_club_path, notice: "Welcome, please create your club!"
    else
      render :new_admin, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user

    if params[:user][:current_password].present?
      if @user.update_with_password(account_update_params)
        bypass_sign_in(@user) # Mantém o usuário logado
        redirect_to user_path(@user), notice: "Your profile was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      # Atualizar sem senha, caso não esteja tentando alterar a senha
      if @user.update(account_update_params.except(:current_password, :password, :password_confirmation))
        redirect_to user_path(@user), notice: "Your profile was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password])
  end

  def after_sign_up_path_for(resource)
    clubs_path
  end

  private

  # Adicionando user_params
  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation, :current_password)
  end
end
