EloLeague.usersRoute = Ember.Route.extend
  model: (params) ->
    @store.find('user', league_id: params.get('league_id'))
