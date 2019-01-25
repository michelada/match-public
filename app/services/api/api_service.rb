module Api
  class ApiService
    def top_teams_format(teams)
      base_obj = {
        "valueNameHeader": "TEAMS",
        "valueHeader": "TOP 5",
        "color": "red",
        "data": [
          {
          "name":"Jean-Luc Picard",
          "value": 1450
          },
          {
          "name":"James Kirk",
          "value": 350
          },
          {
          "name":"Kathryn Janeway",
          "value": 1850
          },
          {
          "name":"Jonathan Archer",
          "value": 1250
          }
        ]
      }
     
      response = base_obj.clone
      response["data"] = []
      teams.each do |team|
        response["data"].push({
          name: team.name,
          value: team.score
        })
      end
      return response.to_json
    end

    def last_activity_format(activity)
      label_obj = {
        "postfix": "MyUnits",
        "color": "blue",
        "data": {
        "value": 1234
        }
      }

      response = label_obj.clone
      response["data"] = []
      postfix = activity.activity_type + "-" + activity.location
      response["postfix"] = postfix
      response["data"].push({
          value: activity.name
      })
      return response.to_json
    end
  end
end
