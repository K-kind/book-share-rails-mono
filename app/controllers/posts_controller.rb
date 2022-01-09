class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = '投稿しました'
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:content, :rate, :image)
  end
end
