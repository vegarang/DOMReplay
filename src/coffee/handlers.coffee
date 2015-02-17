class Handler
  constructor: (@util, @storage) ->
    @util.debug "initializing DOM handlers"

  handle_button_click: (button) =>
    @storage.add_click_event button
    @util.debug 'button was clicked!'
    @util.debug 'id: '+button.id
    @util.debug 'name: '+button.name
    return

  handle_link_click: (link) =>
    @storage.add_click_event link
    @util.debug 'link was clicked!'
    @util.debug 'id: '+link.id
    @util.debug 'name: '+link.name
    return
