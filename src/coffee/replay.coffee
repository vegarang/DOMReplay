class Replay
  constructor: (@main) ->
    @util = @main.util
    @STATE_STOPPED = 0
    @STATE_PLAY = 1

    @current_step = 0
    @default_delay = 500

    @current_state = @STATE_STOPPED

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

    trigger_next_step = (delay=@default_delay) =>
      @util.debug "attempting to trigger next step"
      if @current_step >= @main.storage.data.length
        @main.set_operating_state_passive()
        return
      @util.debug "storage.length (#{@main.storage.data.length}) >= current_step (#{@current_step})"

      window.setTimeout play_step, delay

    play_step = =>
      if @current_state != @STATE_PLAY
        return

      stored_element = @main.storage.data[@current_step]
      @util.debug "replaying! Attempting to execute a #{stored_element.event_type} on #{stored_element.id}"
      element = document.getElementById stored_element.id
      event = new Event(stored_element.event_type)
      element.dispatchEvent(event)

      if stored_element.value != undefined
        element.value = stored_element.value

      @current_step++
      @util.debug "current_step is now #{@current_step}"

      if @main.config.events[stored_element.event_type].delay != undefined
        trigger_next_step(@main.config.events[stored_element.event_type].delay)
      else
        trigger_next_step()

    @util.debug "setting current state to play, and running next step!"
    @current_state = @STATE_PLAY
    trigger_next_step()

  pause: ->
    @util.debug "pausing.."
    @main.set_operating_state_passive()
    @current_state = @STATE_STOPPED

  reset: ->
    @util.debug "stopping playback and resetting counter!"
    @main.set_operating_state_passive()
    @current_state = @STATE_STOPPED
    @current_step = 0


