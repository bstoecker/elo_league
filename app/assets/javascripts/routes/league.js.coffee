EloLeague.LeagueRoute = Ember.Route.extend
  model: ->
    @store.find('user')
