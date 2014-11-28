EloLeague.LeagueRoute = Ember.Route.extend
  model: (params) ->
    @store.find('league', params.league_id)

  setupController: (controller, model) ->
    controller.set('model', model)
