class DomReplay
  constructor: (debugmode) ->
    console.log debugmode
    @util = new Util(debugmode)


  initialize_tracking: () ->
    @util.debug 'running initial load'
    time = setInterval( ()=>
      if document.readyState != 'complete'
        @util.debug 'document not yet ready - postponing initialization'
        return
      clearInterval time
      @initialize_modules()
      return
      100)

  initialize_modules: ->
    @util.debug "running initialize_modules"
    @storage = new Storage this
    @handler = new Handler this
    @dom_loader = new DOMLoader this

    @dom_loader.initialize_buttons()
    @dom_loader.initialize_links()
    @util.debug "all modules initialized"

  initialize_playback: ->
    @replay = new Replay this
    @replay.play()

@DOMReplay_initial_load = (debugmode) ->
  dr = new DomReplay(debugmode)
  dr.initialize_tracking()

  buttonline = document.getElementById 'main_button_line'
  button = document.createElement "button"
  button.className = "btn btn-warning"
  button.innerText = "Trigger replay"
  button.addEventListener 'click', () ->
    dr.initialize_playback()
  , false

  buttonline.appendChild button

  dr
