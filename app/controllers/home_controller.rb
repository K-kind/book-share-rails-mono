class HomeController < ApplicationController
  before_action :require_login, only: [:index]

  def index
    @posts = Post
      .includes(:likes, user: { image_attachment: :blob })
      .left_joins(:likes)
      .group('posts.id')
      .with_attached_image
      .merge(Post.where(user: current_user).or(Post.where(likes: { user: current_user })))
      .page(params[:page])
      .per(10)
      .order(created_at: :desc)
  end
end
