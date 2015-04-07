class DOMLoader
  constructor: (@main) ->
    @util = @main.util
    @util.debug 'running dom_loader initializations'

  add_click_listener_to_element: (element, element_handler) ->
    element.addEventListener 'click', () ->
      element_handler this
    , false

  initialize_click_elements_from_list: (elements, element_handler) ->
    @util.debug "initializing #{elements.length} click-elements"
    @add_click_listener_to_element element, element_handler for element in elements

  initialize_buttons: () ->
    @util.debug 'initializing all buttons'
    @initialize_click_elements_from_list document.getElementsByTagName('button'), @main.handler.handle_button_click

  initialize_links: () ->
    @util.debug 'initializing all links'
    @initialize_click_elements_from_list document.getElementsByTagName('a'), @main.handler.handle_link_click


  initialize_mutation_observer: () =>
    analyze_element = (element) =>
      @util.debug "analyzing element '#{element.id}', '#{element.tagName}'"
      if element.tagName is "BUTTON"
        @add_click_listener_to_element element, @main.handler.handle_button_click

      else if element.tagName is "A"
        @add_click_listener_to_element element, @main.handler.handle_link_click

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
