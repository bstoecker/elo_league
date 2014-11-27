EloLeague.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    @store.find('league')
