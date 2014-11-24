class TasksController < ApplicationController
	before_action :set_tags, only: [:new, :edit]

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
		@task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task.project, notice: 'task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task.project }
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
      p = params[:task].permit(:title, :tag_ids => [])
      p[:tag_ids] = [] if p[:tag_ids].nil?
      p
    end

		def tag_params
			params[:tag].permit(:name)
		end

    def set_tags
      @tags = Tag.all
    end

end
