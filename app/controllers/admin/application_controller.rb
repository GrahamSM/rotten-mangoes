class Admin::ApplicationController < ApplicationController
  
  def check_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end


end
