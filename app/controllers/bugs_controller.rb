class BugsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bug, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
   # @bugs=Bug.all
    @bugs = Bug.accessible_by(current_ability, :update)

    end
  
    def show
      @bug=Bug.find(params[:id])
    end
  
    def edit
      @bug=Bug.find(param[:id])
  
    end
  
    def new
      @bug=Bug.new
    end
  
    def create

      
      @bug = Bug.new(bug_params)
  
      if @bug.save
        #redirect_to bugs_path, notice: 'Bug was successfully created.'
        redirect_to project_path(@bug.project), notice: 'Bug was successfully created.'

      else
        #render :new, status: :unprocessable_entity
        render 'projects/show'

      end

    end
  
  
  
    def destroy
      @bug = Bug.find(params[:id])
      @bug.destroy
  
      redirect_to root_path, status: :see_other
    end
    
    def edit
      @bug=Bug.find(params[:id])
    end
  
    def update
      
      @bug = Bug.find(params[:id])

      if @bug.update(bug_params)
        redirect_to bugs_path, notice: 'Bug was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
     private
  
  def bug_params
    params.require(:bug).permit(:title, :description, :user_id, :project_id)
  
  end
  def set_bug
    @bug = Bug.find(params[:id])
  end
end
