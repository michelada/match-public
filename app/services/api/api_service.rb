module Api
  class ApiService
    def top_teams_format(teams)
      base_obj = obtain_base_object
      response = base_obj.clone
      response['data'] = []
      teams.each do |team|
        response['data'].push(
          name: team.name,
          value: team.total_score
        )
      end
      response.to_json
    end

    def last_activity_format(activity)
      team_name = activity.user.team.name
      activity_location = get_activity_location(activity)
      activity_type = activity.activity_type == "Post" ? "Post" : get_activity_type_en(activity.activity_type)
      response = obtain_label_object.clone
      response['data'] = []
      postfix = "Team #{team_name} - #{activity_type} #{activity_location}"
      response['postfix'] = postfix
      response['data'] = {
        value: activity.name
      }
      response.to_json
    end

    private

    def get_activity_location(activity)
      activity.locations[0] ? "at #{activity.locations.first.name}" : ""
    end

    def get_activity_type_en(activity_type)
      activity_type == "Curso" ? "Course" : "Talk"
    end

    def obtain_base_object
      {
        "valueNameHeader": 'TEAMS',
        "valueHeader": 'TOP 5',
        "color": 'red',
        "data": [
          {
            "name": 'Jean-Luc Picard',
            "value": 1450
          },
          {
            "name": 'James Kirk',
            "value": 350
          }
        ]
      }
    end

    def obtain_label_object
      {
        "postfix": 'MyUnits',
        "color": 'blue',
        "data": {
          "value": 1234
        }
      }
    end
  end
end
