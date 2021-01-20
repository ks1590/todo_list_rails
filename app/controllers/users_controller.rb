class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  PEREVIEW = 10

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  def show
    @user = current_user
    @tasks = @user.tasks&.page(params[:page]).per(PEREVIEW)
    redirect_to tasks_path if @user.id != params[:id].to_i
  end
  
  
  def show
    @user = User.find(params[:id])
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                :password_confirmation)
  end

end
