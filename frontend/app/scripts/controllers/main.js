'use strict';

angular.module('angularApp')
  .controller('MainCtrl', function ($scope, $http, $q) {

    // Chart configuration
    $scope.kcalBreakdownChart = {
      options: {
       title: 'Calorie Breakdown'
      },
      type: 'PieChart',
      data: {
        rows: [],
        cols: [
          {
            id: "n", label: "Nutrient", type: "string"
          },
          {
            id: "p", label: "Percent", type: "number"
          }
        ]
      }
    };

    // This function is a replacement for $.ajax using the Angular $http service
    // It needs to have an abort() method because select2 will abort previous HTTP requests when
    // it sends new ones out
    var fetchFoods = function (queryParams) {
      var aborter = $q.defer();
      var req = $http.get("/api/foods", { params: queryParams.data, timeout: aborter.promise })
        .then(queryParams.success);
      req.abort = function() {
        aborter.resolve();
      };
      return req;
    };

    // Options for the food selector (using Select2). These options are identical to the non-Angular
    // version.
    $scope.foodSelectOptions = {
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
          if(response.data.food) { response.data.food.text = response.data.food.short_desc; }
          callback(response.data.food);
        });
      }
    };

    // This calculates the data for chart and table display of nutrition data
    _.each(['selectedFood','selectedQty','selectedWeightId'], function(e) { $scope.$watch(e, function() {
      if($scope.selectedFood && $scope.selectedFood.macronutrients) {
        var food = $scope.selectedFood;

        // Calculate the calorie breakdown. This uses 9 kcal/g of fat, 4 for carbs, and 4 for
        // protein. This is an approximation!
        var totalKcal = food.macronutrients.kcal;
        $scope.totalKcal = totalKcal;

        var fat = food.macronutrients.total_fat, protein = food.macronutrients.protein,
          carbs = (food.macronutrients.carbs - food.macronutrients.total_fiber),
          totalEstKcal = (fat * 9 + carbs * 4 + protein * 4);
        var kcalPctBreakdown = {
          fat: ((fat * 9)/totalEstKcal) * 100,
          protein: ((protein * 4)/totalEstKcal) * 100,
          carbs: ((carbs * 4)/totalEstKcal) * 100
        };

        $scope.kcalBreakdownChart.data.rows = [
          { c: [{v: 'Fat'}, {v: kcalPctBreakdown.fat}] },
          { c: [{v: 'Carbs'}, {v: kcalPctBreakdown.carbs}] },
          { c: [{v: 'Protein'}, {v: kcalPctBreakdown.protein}] }
        ];

      }
    }); });

    $scope.getNutrientNiceName = function(key) {
      var niceNames = {
        kcal: 'Calories', protein: 'Protein', total_fat: 'Total Fat', carbs: 'Total Carbohydrates',
        total_fiber: 'Total Fiber', sugar: 'Sugar', cholesterol: 'Cholesterol'
      };
      return niceNames[key];
    };

    $scope.getNutrientNiceAmount = function(key,amt) {
      var units = {
        kcal: '', protein: 'g', total_fat: 'g', carbs: 'g',
        total_fiber: 'g', sugar: 'g', cholesterol: 'mg'
      };
      var val = amt * $scope.getGramAmount()/100;
      if(key !== 'kcal') {
        return val.toFixed(2) + units[key];
      } else {
        return parseInt(val);
      }
    };

    $scope.getGramAmount = function() {
      if(!$scope.selectedWeightId || !$scope.selectedQty) {
        return 100;
      } else {
        if(parseInt($scope.selectedWeightId) === 1) {
          return $scope.selectedFood.weights[0].weight * parseFloat($scope.selectedQty);
        } else {
          return $scope.selectedFood.weights[1].weight * parseFloat($scope.selectedQty);
        }
      }
    };

  });
