EloLeague.LeaguesController = Ember.ArrayController.extend
  itemController: 'league'

  newLeagueInputVisible: false

  actions:

    showNewLeageInput: ->
      @set('newLeagueInputVisible', true)

    createNewLeague: ->
      league = @store.createRecord 'league',
        name: @get('newName')
        describtion: @get('newDescribtion')
      league.save().then =>
        @set('newLeagueInputVisible', false)


