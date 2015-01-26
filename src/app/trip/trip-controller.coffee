angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "MapManager", "TripManager", "SpotsManager", "Pubsub",
    ($scope,   $window,   MapManager,   TripManager,   SpotsManager,   Pubsub) ->
      'use strict'

      $scope.TripManager = TripManager
      $scope.spots = SpotsManager.spots()

      $scope.centerMapOnSpot = (spotCoords) -> Pubsub.pub "centerMapOnSpot", spotCoords
      do ->
        $scope.map = MapManager.init()
  ]
