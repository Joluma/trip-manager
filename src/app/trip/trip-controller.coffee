angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "MapManager", "TripManager",
    ($scope,   $window,   odigoSpots,   MapManager,   TripManager) ->
      'use strict'

      $scope.trip = TripManager.trip
      $scope.spots = odigoSpots[0].response

      do ->
        $scope.map = MapManager.init($scope.spots)
  ]
