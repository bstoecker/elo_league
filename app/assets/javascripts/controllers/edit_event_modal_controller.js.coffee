EloLeague.EditEventModalController = Ember.ObjectController.extend

  saveButtonText: I18n.t('annotation.generic.save_button')
  cancelButtonText: I18n.t('annotation.generic.cancel_button')
  title: I18n.t('annotation.event.edit')

  eventNames: Ember.computed 'eventLists', ->
    @store.all('eventList').mapBy('name')

  typeAheadEventNames: Ember.computed 'eventNames', ->
    JSON.stringify(@get('eventNames'))

  dateFrom: Ember.computed 'model.begin', ->
    @get('model.begin')

  dateTo: Ember.computed 'model.end', ->
    @get('model.end')

  actions:
    save: ->
      