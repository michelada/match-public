module Judge
  class LocationsController < MatchesController
    def update
      activity = Activity.friendly.find(params[:activity_id])
      location = activity.locations.find_by(id: params[:id])
      location.update_attributes(approve: !location.approve)
      activity.update_attributes(name: activity.name)
      message = location.approve ? t('labels.location_aproved') : t('labels.location_unaproved')
      flash[:notice] = message
      redirect_to match_judge_activity_path(@match, activity)
    end
  end
end
