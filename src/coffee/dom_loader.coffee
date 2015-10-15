class DOMLoader
  constructor: (@main) ->
    @util = @main.util
    @util.debug 'running dom_loader initializations'

  add_eventlistener_to_element: (element, handler, event) ->
    element.addEventListener event, () ->
      handler this
    , false


  initialize_events: () ->
    for event, conf of @main.config.events
      for tagname in conf.tagnames
        elements = document.getElementsByTagName tagname
        @add_eventlistener_to_element element, conf.handler, event for element in elements
    return


  initialize_mutation_observer: () =>
    analyze_element = (element) =>
      @util.debug "analyzing element '#{element.id}', '#{element.tagName}'"
      for event, conf of @main.config.events
        if element.tagName.toLowerCase() in conf.tagnames
          @util.debug "mutationobserver is adding a #{event}-listener to element #{element.id}"
          @add_eventlistener_to_element element, conf.handler, event

    @util.debug 'initializing mutation_observer'
    observer = new MutationObserver (mutations) =>
      mutations.forEach (mutation) =>
        if mutation.type == 'childList'
          if mutation.addedNodes.length > 0
            analyze_element element for element in mutation.addedNodes

    config =
      childList: true
      subtree: true

    observer.observe document.body, config
    return
