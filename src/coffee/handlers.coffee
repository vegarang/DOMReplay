class Handler
  constructor: (@main) ->
    @util = @main.util
    @util.debug "initializing DOM handlers"

  handle_click_event: (element) =>
    @util.debug "id: #{element.id}, name: #{element.name} was clicked"
    @main.storage.add_click_event element

  handle_change_event: (element) =>
    @util.debug "id: #{element.id}, name: #{element.name} was changed"
    @main.storage.add_change_event element

  handle_input_event: (element) =>
    @main.storage.add_input_event element