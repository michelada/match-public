class UploadsController < ApplicationController
  before_action :user_can_delete_file?

  def destroy
    file = ActiveStorage::Attachment.find(params[:id])
    if file.purge
      flash[:notice] = t('uploads.deleted')
    else
      flash[:alert] = t('uploads.error_deleting')
    end
    redirect_back fallback_location: { action: 'edit', id: @activity }
  end

  private

  def user_can_delete_file?
    @activity = Activity.find(params[:activity_id])
    return if @activity.user == current_user

    flash[:alert] = t('activities.messages.no_permitted')
    redirect_to root_path
  end
end
