class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  before_action :user_can_upload_project?, only: [:new, :create]

  def index
    @projects = @match.projects
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:notice] = t('projects.created')
      redirect_to match_team_path(@match, current_user.team)
    else
      flash[:alert] = t('projects.error_creating')
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    @project.update(project_params)
    if @project.save
      flash[:notice] = t('projects.updated')
      redirect_to match_team_path(@match, current_user.team)
    else
      flash[:alert] = t('projects.error_updating')
      render 'edit'
    end
  end

  private

  def project_params
    params.require(:project)
          .permit(:name, :description, :repositories, :features)
          .merge(match_id: params[:match_id], team_id: current_user.team_id)
  end

  def set_project
    @project = @match.projects.find(params[:id])
  end
end
