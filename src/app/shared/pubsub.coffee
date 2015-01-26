angular
  .module 'tripManager'
  .factory "Pubsub", [
    "$rootScope",
    ($rootScope) ->
      _pub = (channel, message) ->
        $rootScope.$emit(channel, message)

      _sub = (channel, func) ->
        $rootScope.$on(channel, func)

      _unsub = (channel) ->
        $rootScope.$$listeners[channel] = []

      {
        pub: _pub
        sub: _sub
        unsub: _unsub
      }
]
