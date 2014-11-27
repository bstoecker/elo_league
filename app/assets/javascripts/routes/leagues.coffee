EloLeague.LeaguesRoute = Ember.Route.extend
  model: ->
    @store.find('league')

  renderTemplate: ->
    @render outlet: 'leagues'
