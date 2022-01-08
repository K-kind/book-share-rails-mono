class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: sessions_params[:email])
    if user&.authenticate(sessions_params[:password])
      log_in user
      sessions_params[:remember_me] == '1' ? remember(user) : forget(user)
      flash[:notice] = 'ログインしました'
      redirect_to root_url
    else
      @error_message = 'メールアドレスとパスワードの組み合わせが不正です'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def sessions_params
    params.require(:sessions).permit(:email, :password, :remember_me)
  end
end
