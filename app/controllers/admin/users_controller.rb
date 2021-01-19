class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy, :show]
  before_action :require_admin

  PRE = 5

  def index
    @users = User.all.order(id: "ASC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "#{@user.name}の登録内容を更新しました。"
      redirect_to admin_user_path(@user)
    else
      flash.now[:danger] = "更新できませんでした。"
      render :edit
    end
  end  

  def show
    @tasks = @user.tasks
    @tasks = @tasks.page(params[:page]).per(PRE)
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_admin
    unless current_user.admin?
      flash[:warning] = "管理者以外はアクセスできません。"
      redirect_to tasks_path
    end
  end
end
