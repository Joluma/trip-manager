angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "MapManager", "TripManager",
    ($scope,   $window,   odigoSpots,   MapManager,   TripManager) ->
      'use strict'

      $scope.TripManager = TripManager
      $scope.spots = odigoSpots[0].response

      do ->
        $scope.map = MapManager.init($scope.spots)
  ]
