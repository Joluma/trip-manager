angular
  .module 'tripManager.trip'
  .factory "DaySpot", [
    () ->
      class DaySpot
        constructor: (@spot) ->
          @id = @spot.id
          @name = @spot.name
          @coords = @spot.coords
  ]
