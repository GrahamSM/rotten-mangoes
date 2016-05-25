class Admin::ApplicationController < ActionController::Base

  helper_method :current_user, :can_switch_view?

  private
  def check_admin
    unless current_user.admin?
      redirect_to index
    end
  end

  def can_switch_view?
    if current_user.admin?
      true
    else
      false
    end
  end

end
