class Util
  constructor: (@debugmode) ->

  framework_name = 'DOMReplay'

  error: (msg) ->
    console.log framework_name+' - ERROR - '+msg

  debug: (msg) ->
    if @debugmode
      console.log framework_name+' - DEBUG - '+msg

  debug_literal: (msg) ->
    if @debugmode
      console.log msg
