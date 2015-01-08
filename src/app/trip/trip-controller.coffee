angular
  .module 'tripManager.trip'
  .controller 'TripCtrl', [
    "$scope", "$window", "odigoSpots", "Trip",
    ($scope,   $window,   odigoSpots,   Trip) ->
      'use strict'

      trip = new Trip()
      newDay = trip.addDay()

      $scope.spots = odigoSpots[0].response
      $scope.tripSpots = trip.currentDay().spots()

      map = L.map('map').setView([35.673343,139.710388], 9)

      L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
          attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
      }).addTo(map)

      markers = new L.MarkerClusterGroup()
      for spot in $scope.spots
        marker = L.marker(new L.LatLng(spot.coords.latitude, spot.coords.longitude), {
          title: spot.name
        })
        marker.bindPopup 'Welcome to <br> '+spot.name
        markers.addLayer marker
      map.addLayer markers

      $scope.addToTrip = (spot) ->
        trip.currentDay().addSpot(spot)

      $scope.removeFromTrip = (spot) ->
        trip.currentDay().removeSpot(spot)

  ]
