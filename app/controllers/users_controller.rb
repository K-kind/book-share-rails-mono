class UsersController < ApplicationController
  before_action :require_login, only: [:me, :update]

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
    @posts = @user
      .posts
      .includes(:likes, user: { image_attachment: :blob })
      .with_attached_image
      .page(params[:page])
      .per(10)
      .order(created_at: :desc)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def user_update_params
    params.require(:user).permit(:name, :email, :image)
  end
end
