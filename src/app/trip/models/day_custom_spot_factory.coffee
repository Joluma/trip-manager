angular
  .module 'tripManager.trip'
  .factory "DayCustomSpot", [
    'DaySpot',
    (DaySpot) ->
      class DayCustomSpot extends DaySpot
        constructor: (@name, @coords) ->
  ]
