class Storage
  constructor: (@util) ->

  data = []
  is_initialized = true

  add_click_event: (element_id) ->
    if not is_initialized
      @util.error('attempting to add element before storage was initialized!')
      return

    if not element_id
      @util.error 'Cannot add element to storage without valid id!'
      return

    object =
      event_type: 'click'
      id: element_id

    @util.debug 'adding element to storage:'
    @util.debug_literal object

    data.push object

    @util.debug 'storage is now:'
    @util.debug_literal data
    return
