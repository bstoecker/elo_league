EloLeague.DeleteEventModalController = Ember.ObjectController.extend

  yesButtonText: I18n.t('annotation.generic.yes_button')
  noButtonText: I18n.t('annotation.generic.no_button')
  title: Ember.computed 'model.name', ->
    I18n.t('annotation.event.delete_instance_title', {name: @get('model.name')})

  actions:
    save: ->
      event = @get('model')
      workload = event.get('workload')
      event.destroyRecord().then =>
          workload.reload()