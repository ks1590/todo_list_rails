class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  
  PRE = 5
  
  def index
    # @tasks = Task.all.order(created_at: :desc)
    @get_params = task_get_params
    @tasks = Task.search(@get_params)
    if params[:sort_expired]
      @tasks = @tasks.deadline
    elsif params[:sort_priority]
      @tasks = @tasks.priority
    else
      @tasks = @tasks.page(params[:page]).per(PRE)
    end
  end

  def new
    @task = Task.new
    @task.deadline = Date.today
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "登録しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "更新しました。"
    else
      flash[:danger] = "更新に失敗しました。"
      render :edit
    end
  end
  

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除しました。"
  end
  

  private  
  def task_params
    params.require(:task).permit(
      :name,
      :content,
      :deadline,
      :priority,
      :status
    )    
  end

  def set_task
    @task = Task.find(params[:id])    
  end

  def task_get_params
    params.fetch(:search, {}).permit(:name, :status)
  end
end
