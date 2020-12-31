class SessionsController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :destroy]}
  def new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
<<<<<<< HEAD
=======
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash[:danger] = "ログインに失敗しました。"
      render :new
    end
>>>>>>> a3b027ace6a9b6ea5e8fde6353e8e90b3355b7d7
  end
  
  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
