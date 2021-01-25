class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_task, only: [:edit, :update, :show, :destroy]
  
  PRE = 5
  
  def index
    # @tasks = Task.all.order(created_at: :desc)
    # @tasks = Task.all
    # @tasks = @tasks.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
    
    @get_params = task_get_params
    @tasks = Task.search(@get_params)
    if params[:sort_expired]
      @tasks = @tasks.deadline
    elsif params[:sort_priority]
      @tasks = @tasks.priority
    else
      @tasks = @tasks.default
    end
    @tasks = @tasks.page(params[:page]).per(PRE)
  end

  def new
    @task = Task.new
    @task.deadline = Date.today
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, success: "新しいToDoリストを登録しました！"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, info: "#{@task.name}を更新しました。"
    else
      flash[:danger] = "更新に失敗しました。"
      render :edit
    end
  end  

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, danger: "#{@task.name}を削除しました。"
  end

  private  
  def task_params
    params.require(:task).permit(
      :name,
      :content,
      :deadline,
      :priority,
      :status,
      label_ids:[]
    )    
  end

  def set_task
    @task = Task.find(params[:id])    
  end

  def task_get_params
    params.fetch(:search, {}).permit(:name, :status, :label_id )
  end
end
