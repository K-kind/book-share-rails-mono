class HomeController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @posts = current_user
      .posts
      .includes(:likes, user: { image_attachment: :blob })
      .with_attached_image
      .page(params[:page])
      .per(10)
      .order(created_at: :desc)
  end
end
