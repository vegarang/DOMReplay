class Storage
  constructor: (@main) ->
    @util = @main.util
    @data = []
    @is_initialized = true

  reset: ->
    @data = []

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

  add_event: (element, event, add_value=false) =>
    @util.debug "adding event to storage"
    if not @_ok_to_store_event element
      return

    object =
      event_type: event
      id: element.id

    if add_value
      object['value'] = element.value

    @data.push object

    # Uncomment this line to see full datastructure of storage on save..
    # @util.debug_literal JSON.stringify @data
    return

  update_storage: (new_data) =>
    @util.debug "updating storage.data."
    @util.debug "new data:"
    @util.debug_literal new_data
    @data = new_data

