angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "Trip",
    ($scope,   $window,   odigoSpots,   Trip) ->
      'use strict'

      trip = new Trip()
      newDay = trip.addDay()

      $scope.spots = odigoSpots[0].response
      console.log $scope.spots[0]
      $scope.tripSpots = trip.currentDay().spots()

      $scope.addToTrip = (spot) ->
        trip.currentDay().addSpot(spot)

      $scope.removeFromTrip = (spot) ->
        trip.currentDay().removeSpot(spot)

  ]
