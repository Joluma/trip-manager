angular
  .module 'tripManager.trip'
  .service 'SpotsManager', [
    "odigoSpots",
    (odigoSpots) ->
      'use strict'

      @spots = -> odigoSpots[0].response
      @
  ]
