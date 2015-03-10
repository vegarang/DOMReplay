class Replay
  constructor: (@main) ->
    @util = @main.util

  play: ->
    @main.storage.record_input = false
    for stored_element in @main.storage.data
      @util.debug "replaying! Attempting to execute a #{stored_element.event_type} on #{stored_element.id}"
      element = document.getElementById stored_element.id

      # this, naturally needs refinement. Assuming click is baaad..
      # Should probably create a proper event, rather than just running click.
      element.click()

    @main.storage.record_input = true
