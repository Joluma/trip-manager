angular
  .module 'tripManager.trip'
  .factory "DaySpot", [
    () ->
      class DaySpot
        constructor: (@spot) ->
          @id = @spot.id
          @name = @spot.name
          @top_tip = @spot.top_tip.text.en
          @coords = @spot.coords
          @image = @spot.cover_image_url
          @tags = @spot.tags
  ]
