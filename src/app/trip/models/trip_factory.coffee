angular
  .module 'tripManager.trip'
  .factory "Trip", [
    'TripDay',
    (TripDay) ->
      class Trip
        _days = null
        _currentDayIndex = null

        constructor: () ->
          _days = []
          _currentDayIndex = 0

        currentDay: ->
          _days[_currentDayIndex]

        addDay: ->
          newDay = new TripDay()
          _days.push newDay
          setCurrentDay newDay
          newDay

        # private methods

        setCurrentDay = (day) ->
          _currentDayIndex = i for d, i in _days when d is day
         
  ]
