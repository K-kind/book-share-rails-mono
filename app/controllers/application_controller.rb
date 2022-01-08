class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    return if logged_in?

    flash[:danger] = 'ログインが必要です'
    redirect_to login_url
  end
end
