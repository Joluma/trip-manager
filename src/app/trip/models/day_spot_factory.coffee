angular
  .module 'tripManager.trip'
  .factory "DaySpot", [
    () ->
      class DaySpot
        constructor: (@spot) ->
          @[key] = _.clone @spot[key] for key of @spot

        trimedData: ->
          {
            id: @id
            trip_item_id: @trip_item_id,
            orderIndex: parseInt @orderIndex
          }
  ]
