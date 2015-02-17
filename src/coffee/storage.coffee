class Storage
  constructor: (@util) ->

  data = []
  is_initialized = true

  add_click_event: (element) ->
    if not is_initialized
      @util.error('attempting to add element before storage was initialized!')
      return

    if not element.id
      @util.error 'Cannot add element to storage without id!'
      return

    object =
      event_type: 'click'
      id: element.id

    @util.debug 'adding element to storage:'
    @util.debug_literal object

    data.push object

    @util.debug 'storage is now:'
    @util.debug_literal data
    return
