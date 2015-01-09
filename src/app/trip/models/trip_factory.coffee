angular
  .module 'tripManager.trip'
  .factory "Trip", [
    'TripDay',
    (TripDay) ->
      class Trip
        _days = null
        _currentDayIndex = null

        days: -> _days
        
        constructor: () ->
          _days = []
          _currentDayIndex = -1

        currentDayIndex: ->
          _currentDayIndex

        currentDay: ->
          _days[_currentDayIndex]

        prevDay: ->
          if _days[_currentDayIndex - 1]?
            _currentDayIndex -= 1
          
        nextDay: ->
          if _days[_currentDayIndex + 1]?
            _currentDayIndex += 1
          
        addDay: ->
          newDay = new TripDay()
          _days.push newDay
          setCurrentDay newDay
          newDay

        # private methods

        setCurrentDay = (day) ->
          _currentDayIndex = i for d, i in _days when d is day
         
  ]
