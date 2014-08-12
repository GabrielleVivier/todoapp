class TasksController < ApplicationController

  before_filter :find_task, :only => [:show, :edit, :update, :destroy]
  before_filter :find_info_in_session, :only => [:new]

  def index
    @tasks = Task.order(priority: :desc)
  end

  def show
  end

  def new
   @task ||= Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.valid?
      @task.save
      flash[:notice] = "Your task was successfully added to your todo list!"
      redirect_to tasks_path
    else
      flash[:notice] = @task.errors.messages
      store_info_in_session(@task)
      redirect_to :back
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
    flash[:notice] = "Your task was successfully updated!"
    redirect_to tasks_path
  end

  def destroy
    @task.destroy
    flash[:notice] = "Your task was successfully deleted!"
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit(:name, :priority, :due_date)
  end
  def find_task
    @task = Task.find(params[:id])
  end
  def find_info_in_session
    @task = session[:task]
  end
  def store_info_in_session(task)
    session[:task] = task
  end

end
