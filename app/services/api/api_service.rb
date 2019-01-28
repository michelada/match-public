module Api
  class ApiService
    def top_teams_format(teams)
      base_obj = obtain_base_object
      response = base_obj.clone
      response['data'] = []
      teams.each do |team|
        response['data'].push(
          name: team.name,
          value: team.score
        )
      end
      response.to_json
    end

    def last_activity_format(activity)
      team_name = activity.user.team.name
      activity_location = activity.locations[0].name
      label_obj = {
        "postfix": "MyUnits",
        "color": "blue",
        "data": {
          "value": 1234
        }
      }

      response = label_obj.clone
      response["data"] = []
      postfix = "Team #{team_name} - #{activity.activity_type} at #{activity_location}"
      response["postfix"] = postfix
      response["data"] = {
        value: activity.name
      }
      response.to_json
    end

    private

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
