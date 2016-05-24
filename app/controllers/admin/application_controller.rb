class Admin::ApplicationController < ActionController::Base



  private
  def check_admin
    current_user.admin?
  end

end
