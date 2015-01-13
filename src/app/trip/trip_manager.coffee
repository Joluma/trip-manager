angular
  .module 'tripManager.trip'
  .service 'TripManager', [
    "Trip",
    (Trip) ->
      'use strict'

      @trip = new Trip()
      @trip.addDay()

      @previousDayExists = -> @trip.days()[@trip.currentDayIndex() - 1]?
      @nextDayExists = -> @trip.days()[@trip.currentDayIndex() + 1]?

      @
  ]
