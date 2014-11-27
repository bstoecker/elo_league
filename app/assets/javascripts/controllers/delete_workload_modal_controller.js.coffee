EloLeague.DeleteWorkloadModalController = Ember.ObjectController.extend

  yesButtonText: I18n.t('annotation.generic.yes_button')
  noButtonText: I18n.t('annotation.generic.no_button')
  title: Ember.computed 'model.name', ->
    "#{I18n.t('annotation.generic.delete_button')} #{@get('model.name')}"

  deleteConfirmed: false

  actions:
    save: ->
      @get('model').destroyRecord().then =>
        @set('deleteConfirmed', false)
        firstWorkload = @store.all('workload').objectAt(0)
        @transitionTo "workloads.show", firstWorkload if firstWorkload
      