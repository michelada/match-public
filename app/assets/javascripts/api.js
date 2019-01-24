var base_obj = {
   "postfix": "Top 3 Teams",
   "color": "green",
   "data": [
       {
           "name":"Sunday",
           "value": 1450
       },
       {
           "name":"Sunday",
           "value": 1450
       }
   ]
}

var query_data = [
   {
       "name": "los apis",
       "score": 100
   },
   {
       "name": "121212",
       "score": 98
   },
   {
       "name": "prueba2",
       "score": 90
   }
];

function copyObj(obj) {
   return Object.assign({}, obj);
}

function createFormat(data_array) {
   var response = copyObj(base_obj);
   response.data = [];
   data_array.map((team) => {
        response.data.push({
           "name": team.name,
           "value": team.score
        });
   });
   return response;
}