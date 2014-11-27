EloLeague.LeaguesRoute = Ember.Route.extend
  model: ->
    @store.find('league')
