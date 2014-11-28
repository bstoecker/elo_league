EloLeague.LeaguesRoute = Ember.Route.extend
  model: ->
    console.log('league route')
    @store.find('league')

  renderTemplate: ->
    @render outlet: 'leagues'
