//= require jquery/dist/jquery.js
//= require jqueryui/ui/datepicker.js
//= require highstock-release
//= require ../../../vendor/assets/bower_components/moment/min/moment-with-locales.js
//= require ../../../vendor/assets/bower_components/handlebars/handlebars
//= require ../../../vendor/assets/bower_components/ember/ember
//= require ../../../vendor/assets/bower_components/ember-data/ember-data
//= require_self
//= require ember-setup

console.log("Wat?");

EloLeague = Ember.Application.create({
  rootElement: '#main-contents',
  LOG_TRANSITIONS: true
});
