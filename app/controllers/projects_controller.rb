class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update]
  before_action :user_can_upload_project?, only: [:new, :create]
  before_action :user_can_modify_project?, only: [:update, :edit]

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
      redirect_to match_team_path(@match, current_user.current_team)
    else
      flash[:alert] = t('projects.error_creating')
      render 'new'
    end
  end

  def show
    @feedback = Feedback.new
  end

  def edit; end

  def update
    @project.update(project_params)
    if @project.save
      flash[:notice] = t('projects.updated')
      redirect_to match_team_path(@match, current_user.current_team)
    else
      flash[:alert] = t('projects.error_updating')
      render 'edit'
    end
  end

  private

  def project_params
    params.require(:project)
          .permit(:name, :description, :repositories, :features)
          .merge(match_id: params[:match_id], team: current_user.current_team)
  end

  def set_project
    @project = @match.projects.friendly.find(params[:id])
  end

  def user_can_modify_project?
    project = Project.friendly.find(params[:id])
    return if project.team == current_user.current_team

    flash[:alert] = t('activities.messages.no_permitted')
    redirect_to new_match_team_path(@match)
  end

  def user_can_upload_project?
    if current_user.current_team.nil?
      flash[:alert] = t('projects.no_team')
      redirect_to new_match_team_path(@match)
    elsif current_user.project
      flash[:alert] = t('projects.already_have_one')
      redirect_to match_team_path(@match, current_user.current_team)
    elsif @match.content_match?
      flash[:alert] = t('match.error_type')
      redirect_to root_path
    end
  end
end
