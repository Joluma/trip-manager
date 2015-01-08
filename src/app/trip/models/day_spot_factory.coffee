angular
  .module 'tripManager.trip'
  .factory "DaySpot", [
    () ->
      class DaySpot
        constructor: (@spot) ->
          @id = @spot.id
          @name = @spot.name
          @address = @spot.address
          @coords = @spot.coords
          @image = @spot.cover_image_url
  ]
