class TeamInvitationsController < ApplicationController
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze

  def new
    render "new"
  end
  
  def create
    if validate_user && invite_user
      flash[:notice] = "Usuario agregado correctamente"
      redirect_to team_path(current_user.team)
    else
      render new_team_path
    end
  end
  

  private

  def team_invitations_params
    params.permit(:email)
  end

  def invite_user
    user_email = params[:email]
    user = User.find_by(email: user_email)
    unless user.nil?
      if user.team.nil?
        user.update_attributes(team_id: current_user.team_id)
      else
        flash[:alert] = "Este usuario ya tiene un equipo"
        return false
      end
    else
      User.invite!({ email: user_email }, current_user)
    end
  end

  def validate_user
    user = params[:email]
    if user.empty? || !user.match(VALID_EMAIL_REGEX)
      flash[:alert] = "El email ingresado no es valido"
      return false 
    end

    return true
  end
end