class HomeController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @posts = current_user.posts.page(params[:page]).per(10).order(created_at: :desc)
  end
end
