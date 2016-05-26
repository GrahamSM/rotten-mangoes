class Admin::ApplicationController < ActionController::Base

  before_action :check_admin
  helper_method :current_user, :can_switch_view?
  layout 'application'

  protected

  def check_admin
    unless current_user.admin?
      flash[:notice] = "You must be an admin to view that page"
      redirect_to root_path
    end
  end

  def can_switch_view?
    if current_user.admin?
      true
    else
      false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end



end
