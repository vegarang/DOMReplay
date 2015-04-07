class Replay
  constructor: (@main) ->
    @util = @main.util

  play: ->
    ###
  This function will replay all recorded events. This happens in several stages:
   - recording is disabled
   - all events in storage are looped through
   - javascript Events are created matching the event from storage, and dispatched on the element from storage
   - recording is re-enabled

  TODO: Add graphical clicks to the elements being clicked, and ensure that the element in question is in the users current view.
    ###
    @main.storage.record_input = false
    for stored_element in @main.storage.data
      @util.debug "replaying! Attempting to execute a #{stored_element.event_type} on #{stored_element.id}"
      element = document.getElementById stored_element.id
      event = new Event(stored_element.event_type)
      element.dispatchEvent(event)

    @main.storage.record_input = true
