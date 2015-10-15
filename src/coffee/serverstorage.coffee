class ServerStorage
  constructor: (@main) ->
    @util = @main.util
    if @main.config.server.sessionid
      @load_from_server()

  load_from_server = () =>
    if not @main.config.server.url
      @util.error "Cannot load from server without url!"
      return