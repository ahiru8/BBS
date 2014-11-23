class TasksController < ApplicationController

	def new
		@project = Project.find(params[:project_id])
		@task = @project.tasks.new
  end

  # GET /tasks/1/edit
  def edit
		@project = Project.find(params[:project_id])
		@task = Task.find(params[:id])
  end

	def create
		@project = Project.find(params[:project_id])
		@task = @project.tasks.create(task_params)
		redirect_to project_path(@project.id)
	end

	# PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to project_path(params[:project_id])
	end

	def toggle
		render nothing: true
		@task = Task.find(params[:id])
		@task.done = !@task.done
		@task.save
	end



	private

		def task_params
			params[:task].permit(:title, :tag_ids => [])
		end

end
