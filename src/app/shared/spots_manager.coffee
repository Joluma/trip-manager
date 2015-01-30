angular
  .module 'tripManager'
  .service 'SpotsManager', [
    "odigoSpots",
    (odigoSpots) ->
      'use strict'

      @spots = -> odigoSpots[0].response

      @spotsHash = ->
        _spotsHash = {}
        for spot, i in odigoSpots[0].response
          _spotsHash[spot.id] = spot
          _spotsHash[spot.id].orderIndex = i
        _spotsHash

      @
  ]
