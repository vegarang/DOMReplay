class Handler
  constructor: (@main) ->
    @util = @main.util
    @util.debug "initializing DOM handlers"

  add_click_event: (element) =>
    @util.debug "adding click event"
    @main.storage.add_event element, 'click', false

  add_change_event: (element) =>
    @util.debug "adding change event"
    @main.storage.add_event element, 'change', true

  add_input_event: (element) =>
    @util.debug "adding input event"
    @main.storage.add_event element, 'input', true