EloLeague.ApplicationRoute = Ember.Route.extend

  model: ->
    @store.find('user').then =>
      @store.find('league')