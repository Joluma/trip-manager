angular
  .module 'tripManager.trip'
  .service 'TripManager', [
    "Trip",
    (Trip) ->
      'use strict'

      @trip = new Trip()
      @trip.addDay()

      @
  ]
