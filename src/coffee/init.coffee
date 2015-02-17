initialize_modules = (util) ->
  storage = new Storage util
  handler = new Handler util, storage
  dom_loader = new DOMLoader util, handler

  dom_loader.initialize_buttons()
  dom_loader.initialize_links()

@DOMReplay_initial_load = ->
  util = new Util(true)

  util.debug 'running initial load'
  time = setInterval( ()->
    if document.readyState != 'complete'
      util.debug 'document not yet ready - postponing initialization'
      return
    clearInterval time
    initialize_modules util
    return
    100)
  return
