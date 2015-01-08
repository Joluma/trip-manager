angular
  .module 'tripManager.trip'
  .factory "TripDay", [
    'DaySpot', 'DayCustomSpot',
    (DaySpot,   DayCustomSpot) ->
      class TripDay
        _spots = null

        constructor: () ->
          _startBase = null
          _endBase = null
          _spots = []

        setStartBase: ->

        setEndBase: -> 

        spots: ->
          _spots

        addSpot: (@spot) ->
          newSpot = new DaySpot(@spot)
          _spots.push newSpot
          newSpot

        removeSpot: (@spot) ->
          _spots.splice i,1 for spot, i in _spots when spot?.id == @spot.id

        # private methods
  ]
