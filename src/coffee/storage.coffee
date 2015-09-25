class Storage
  constructor: (@main) ->
    @util = @main.util
    @data = []
    @is_initialized = true

  add_click_event: (element) ->
    if not @is_initialized
      @util.error('attempting to add element before storage was initialized!')
      return

    if not @main.operating_state_is_recording()
      @util.debug "cancelling storage due to current operating state not set to record"
      return

    if element.hasAttribute "DomReplayIgnore"
      @util.error 'Cannot track ignored element'
      return

    if not element or not element.id
      @util.error 'Cannot add element to storage without valid id!'
      return

    object =
      event_type: 'click'
      id: element.id

    @util.debug 'adding element to storage:'
    @util.debug_literal object

    @data.push object

    @util.debug 'storage is now:'
    @util.debug_literal @data
    return
