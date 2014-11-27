Ember.Handlebars.registerHelper 't', (property, options) ->
  params = options.hash
  self = this

  for key in Object.keys(params)
    params[key] = Em.Handlebars.get(self, params[key], options)

  I18n.t(property, params)
