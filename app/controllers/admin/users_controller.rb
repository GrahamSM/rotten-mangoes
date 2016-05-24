class Admin::UsersController < ActionController::Base

  def index
    binding.pry
    @users = User.all
  end

end
