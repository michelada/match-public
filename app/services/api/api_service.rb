module Api
  class ApiService
    def top_teams_format(teams)
      base_obj = {
        "valueNameHeader": "MCM",
        "valueHeader": "Top 5 Teams",
        "color": "green",
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
  end
end
