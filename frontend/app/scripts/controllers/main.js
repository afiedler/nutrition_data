'use strict';

angular.module('angularApp')
  .controller('MainCtrl', function ($scope, $http, $q) {

    var fetchFoods = function (queryParams) {
      var aborter = $q.defer();
      var req = $http.get("/api/foods", { params: queryParams.data, timeout: aborter.promise })
        .then(queryParams.success);
      req.abort = function() {
        aborter.resolve();
      };
      return req;
    };

    $scope.foodSelectOptions = {
      placeholder: "Search for a food",
      minimumInputLength: 1,
      ajax: {
        data: function (term) {
          return { short_desc: term };
        },
        transport: fetchFoods,
        results: function (result) {
          return { results: _.map(result.data.foods, function(f) {
              f.text = f.short_desc;
              return f;
            })
          };
        }
      },
      initSelection : function (element, callback) {
        var id = element.val();
        $http.get("/api/foods/" + id).then(function(response) {
          response.data.food.text = response.data.food.short_desc;
          callback(response.data.food);
        });
      }
    };

    $scope.selectedFood = null;

    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
