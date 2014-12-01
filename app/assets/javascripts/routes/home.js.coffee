EloLeague.HomeRoute = Ember.Route.extend
  model: ->
    @store.find('league')
  renderTemplate: ->