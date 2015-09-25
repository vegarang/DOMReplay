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
    if @main.operating_state_is_replaying()
      @util.debug 'replay initialization cancelled due to replay already running'
      return
    @main.set_operating_state_replay()

    delay = 500
    current_step = 0

    trigger_next_step = =>
      if current_step >= @main.storage.data.length
        @main.set_operating_state_passive()
        return
      @util.debug "storage.length (#{@main.storage.data.length}) >= current_step (#{current_step})"

      window.setTimeout replay_step, delay

    replay_step = =>
      stored_element = @main.storage.data[current_step]
      @util.debug "replaying! Attempting to execute a #{stored_element.event_type} on #{stored_element.id}"
      element = document.getElementById stored_element.id
      event = new Event(stored_element.event_type)
      element.dispatchEvent(event)
      current_step++
      @util.debug "current_step is now #{current_step}"

      trigger_next_step()
    trigger_next_step()

