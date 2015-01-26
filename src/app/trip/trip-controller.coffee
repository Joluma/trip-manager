angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "MapManager", "TripManager", "SpotsManager",
    ($scope,   $window,   MapManager,   TripManager,   SpotsManager) ->
      'use strict'

      $scope.TripManager = TripManager
      $scope.spots = SpotsManager.spots()

      do ->
        $scope.map = MapManager.init()
  ]
