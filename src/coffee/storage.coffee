class Storage
  constructor: (@main) ->
    @util = @main.util
    @data = []
    @is_initialized = true

  _ok_to_store_event: (element) ->
    if not @is_initialized
      @util.error('attempting to add element before storage was initialized!')
      return false

    if not @main.operating_state_is_recording()
      @util.debug "cancelling storage due to current operating state not set to record"
      return false

    if element.hasAttribute "DomReplayIgnore"
      @util.error 'Cannot track ignored element'
      return false

    if not element or not element.id
      @util.error 'Cannot add element to storage without valid id!'
      return false

    return true

  add_event: (element, event, add_value=false) ->
    if not @_ok_to_store_event element
      return

    object =
      event_type: event
      id: element.id

    if add_value
      object['value'] = element.value

    @data.push object

    return

  add_click_event: (element) ->
    @add_event element, 'click', false

  add_change_event: (element) ->
    @add_event element, 'change', true

  add_input_event: (element) ->
    @add_event element, 'input', true
