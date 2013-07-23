class TasksController < ApplicationController
  def index
    if current_user
    	@incomplete = current_user.tasks.where(complete: false)
      @complete = current_user.tasks.where(complete: true)
    end
  end

  def create
  	@task = current_user.tasks.new(task_params)
  	if @task.save
  		flash[:success] = "Task added succesfully"
  	else
  		flash[:notice] = "Task failed to be added"
  	end
  	redirect_to tasks_path
  end

  def update
  	@task = current_user.tasks.find(params[:id])
  	@task.update_attributes!(task_params)
  	respond_to do |format|
  		format.html { redirect_to tasks_path }
  		format.js
  	end
  end

  def destroy
  	@task = current_user.tasks.find(params[:id])
  	@task.destroy
  	respond_to do |format|
  		format.html { redirect_to tasks_path }
  		format.js
  	end
  end

  private

  	def task_params
  		params.require(:task).permit(:content, :complete)
  	end



end
