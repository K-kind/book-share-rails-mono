class LikesController < ApplicationController
  before_action :require_login

  def create
    post = Post.find(params[:post_id])
    like = post.likes.new(user: current_user)

    flash[:danger] = 'いいねに失敗しました' unless like.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    like = current_user.likes.find_by(post_id: params[:post_id])
    like.destroy!
    redirect_back(fallback_location: root_path)
  end
end
