EloLeague.TypeaheadInputFieldView = Ember.TextField.extend

  classNames: ["string", "required", "full-width"]
  attributeBindings: ['autocomplete', 'data-provide', 'data-items', 'data-source', 'placeholder']
  autocomplete: "off"
  "data-provide": "typeahead"
  "data-items": 8