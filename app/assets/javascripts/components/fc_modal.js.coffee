EloLeague.FcModalComponent = Ember.Component.extend
  actions: {
    ok: ->
      @$(".modal").modal "hide"
      @sendAction "ok"
  },
  show: (->
    @$(".modal").modal().on "hidden.bs.modal", (->
      @sendAction "close"
    ).bind(this)
  ).on("didInsertElement")