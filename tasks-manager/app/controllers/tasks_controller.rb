class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle_complete]
    before_action :set_categories, only: [:new, :edit, :create, :update]
  
    def index
      @tasks = Task.all
      @tasks = @tasks.where(completed: false) if params[:filter] == "incomplete"
      @tasks = @tasks.where(completed: true) if params[:filter] == "complete"
      @tasks = @tasks.where(category_id: params[:category_id]) if params[:category_id]
      @categories = Category.all
    end
  
    def new
      @task = Task.new
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        redirect_to tasks_path, notice: 'Task created successfully'
      else
        render :new
      end
    end

    def show
        # The task is already set by the before_action
    end
  
    def edit
    end
  
    def update
      if @task.update(task_params)
        redirect_to tasks_path, notice: 'Task updated successfully'
      else
        render :edit
      end
    end
  
    def destroy
      @task.destroy
      redirect_to tasks_path, notice: 'Task deleted'
    end
  
    def toggle_complete
      @task.update(completed: !@task.completed)
      redirect_to tasks_path
    end
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def set_categories
      @categories = Category.all
    end
  
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :completed, :category_id)
    end
  end
  