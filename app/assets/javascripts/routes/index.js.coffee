EloLeague.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo 'home'