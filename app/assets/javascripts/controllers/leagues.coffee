EloLeague.LeaguesController = Ember.ArrayController.extend

  newLeagueInputVisible: false

  actions:

    showNewLeageInput: ->
      @set('newLeagueInputVisible', true)

    createNewLeage: ->
      @set('newLeagueInputVisible', false)


