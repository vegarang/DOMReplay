class Handler
  constructor: (@main) ->
    @util = @main.util
    @util.debug "initializing DOM handlers"

  handle_button_click: (button) =>
    @util.debug 'button was clicked!'
    @util.debug 'id: '+button.id
    @util.debug 'name: '+button.name
    @main.storage.add_click_event button
    return

  handle_link_click: (link) =>
    @util.debug 'link was clicked!'
    @util.debug 'id: '+link.id
    @util.debug 'name: '+link.name
    @main.storage.add_click_event link
    return