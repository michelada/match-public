module Api
  class ApiService
    def top_teams_format(teams)
      return numerics_top_list_data if teams.empty?

      response = numerics_top_list_data.clone
      response['data'] = []
      teams.each do |team|
        response['data'].push(
          name: team.name,
          value: team.score
        )
      end
      response.to_json
    end

    def winner_team(team)
      return numerics_top_list_data if team.nil?

      response = numerics_label_data.clone
      response['data'] = []
      response['postfix'] = I18n.t('api.score', score: team&.score)
      response['data'] = {
        value: I18n.t('api.winner', team: team.name)
      }
      response.to_json
    end

    def last_activity_format(activity)
      return numerics_label_data if activity.nil?

      activity_type = activity.activity_type == 'Post' ? 'Post' : get_activity_type_en(activity.activity_type)
      response = numerics_label_data.clone
      response['data'] = []
      response['postfix'] = I18n.t('api.team', team: activity.user.current_team.name, activity_type: activity_type)
      response['data'] = {
        value: activity.name
      }
      response.to_json
    end

    def top_activities_format(activity)
      response = numerics_top_list_data.clone
      response['data'] = []
      response['valueNameHeader'] = I18n.t('activities.title')
      response['valueHeader'] = 'TOP 3'
      activity.each_with_index do |activities, index|
        response['data'].push(
          name: "#{Activity.activity_types.keys[index]}-#{activities.first&.name}",
          value: activities.first&.points
        )
      end
      response.to_json
    end

    def project_match_message
      response = numerics_label_data.clone
      response['data'] = []
      response['postfix'] = I18n.t('api.errors.no_content_match')
      response['data'] = I18n.t('api.errors.no_content_match')
      response.to_json
    end

    private

    def get_activity_type_en(activity_type)
      activity_type == 'Curso' ? 'Course' : 'Talk'
    end

    def numerics_top_list_data
      {
        "valueNameHeader": 'TEAMS',
        "valueHeader": 'TOP 5',
        "color": 'red',
        "data": [
          {
            "name": I18n.t('api.errors.no_teams_created'),
            "value": 0
          }
        ]
      }
    end

    def numerics_label_data
      {
        "postfix": 'Activities',
        "color": 'blue',
        "data": {
          "value": I18n.t('api.errors.no_activities')
        }
      }
    end
  end
end
