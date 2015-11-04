class ServerStorage
  constructor: (@main) ->
    @util = @main.util
    @conf = @main.config.server
    @load_from_server()

  ready_to_load: () =>
    if not @conf.url
      @util.debug "Cannot make call to server without url!"
      return false

    if not @main.operating_state_is_passive()
      @util.debug "Cannot make a call to server while state is not passive!"
      return false

    return not @conf.is_loading

  _parse_response: () =>
    console.log "request.onreadystatechange: readyState: #{@request.readyState}, status: #{@request.status}"

    if @request.readyState is 4 && @request.status is 200
      @util.debug "Got response!!"
      @conf.is_loading = false
      response = JSON.parse @request.responseText
      if response.status is "success"
        @util.debug "Success!"
        @main.storage.update_storage response.data
      else
        @util.error "Got error from server: #{response.msg}"


  load_from_server: () =>
    if not @ready_to_load()
      return

    @conf.is_loading = true

    urlstring = "#{@conf.url}?session_id=#{@conf.session_id}"
    if @conf.user_id
      urlstring = "#{urlstring}&user_id=#{@conf.user_id}"

    @util.debug "Attempting to load from url: #{urlstring}"
    @util.debug "conf.user_id: #{@conf.user_id}, conf.session_id: #{@conf.session_id}, conf.url: #{@conf.url}"
    @util.debug "conf:"
    @util.debug_literal @conf

    @request = new XMLHttpRequest()
    @request.overrideMimeType "application/json"
    @request.open 'GET', urlstring, true
    @request.onreadystatechange = @_parse_response

    @request.send null

  push_to_server: () =>
    if not @ready_to_load()
      return

    @conf.is_loading = true

    @request = new XMLHttpRequest()
    @request.overrideMimeType "application/json"
    @request.open 'POST', @conf.url, true

    @request.setRequestHeader "Content-Type", "application/json"
    @request.setRequestHeader "Origin", "#{@conf.url}"
    @request.onreadystatechange = @_parse_response

    data =
      user_id: @conf.user_id
      session_id: @conf.session_id
      data: @main.storage.data

    @request.send JSON.stringify data
