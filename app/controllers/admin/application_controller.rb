class Admin::ApplicationController < ActionController::Base


  private
  def check_admin
    unless current_user.admin?
      redirect_to index
    end
  end

end
