class UsersController < ApplicationController
  before_action :require_login, only: %i[me update following followers]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:notice] = '新規登録が完了しました'
      redirect_to root_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def me
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_update_params)
      flash[:notice] = 'ユーザー情報の変更を保存しました'
      redirect_to mypage_url
    else
      render :me, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post
             .includes(:likes, user: { image_attachment: :blob })
             .left_joins(:likes)
             .group('posts.id')
             .with_attached_image
             .merge(Post.where(user: @user).or(Post.where(likes: { user: @user })))
             .page(params[:page])
             .per(10)
             .order(created_at: :desc)
  end

  def index
    @users = User
             .all
             .with_attached_image
             .includes(:active_relationships, :passive_relationships)
             .page(params[:page])
             .per(10)
             .order(created_at: :asc)
  end

  def following
    @user = User.find(params[:id])
    @users = @user
             .following
             .with_attached_image
             .includes(:active_relationships, :passive_relationships)
             .page(params[:page])
             .per(10)
             .order(created_at: :asc)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user
             .followers
             .with_attached_image
             .includes(:active_relationships, :passive_relationships)
             .page(params[:page])
             .per(10)
             .order(created_at: :asc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :image, :description)
  end
end
