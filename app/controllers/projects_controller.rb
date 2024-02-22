class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index


   # @projects = current_user.projects
    @projects = Project.accessible_by(current_ability)

    #@projects = Project.all

   # if @projects.any?
     # @bugs = @projects.first.bugs
    #else
     # @bugs = [] # or handle the case where there are no projects
   # end    
    end
  
    def show
      @project=Project.find(params[:id])
      
    end
  
    def edit
      @project=Project.find(params[:id])
  
    end
  
    def new
      @project = Project.new

      @developers_and_qas = User.where(role: ['developer', 'qa'])
    end
  
    def create
      @project = Project.new(project_params)
      #@project = current_user.projects.new(project_params) if current_user.developer?

      case @project.assigned_user_role
      when 'developer', 'qa'
        @project.user = User.find_by(role: @project.assigned_user_role)
      end
  
      if @project.save
        redirect_to projects_path, notice: 'Project was successfully created.'
      else
        @developers_and_qas = User.where(role: ['developer', 'qa'])
        render :new, status: :unprocessable_entity
      end
    end
  
  
    def destroy
      @project = Project.find(params[:id])
      @project.destroy
  
      redirect_to root_path, status: :see_other
    end
    
    def edit
      @project=Project.find(params[:id])
    end
  
    def update
      @project = Project.find(params[:id])

      if @project.update(project_params)
        redirect_to projects_path, notice: 'Project was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
     private
  
  def project_params
    params.require(:project).permit(:name,:user_id,:assigned_user_role)
  
  end
  def set_project
    @project = Project.find(params[:id])
  end

end
