class SessionsController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :destroy]}

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = 'ログインしました'
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:warning] = "ログインに失敗しました。"
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:info] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
