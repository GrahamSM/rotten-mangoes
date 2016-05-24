class Admin::UsersController < ActionController::Base

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    binding.pry
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
