class DOMLoader
  constructor: (@util, @handler) ->
    util.debug 'running dom_loader initializations'

  initialize_click_elements_from_list: (elements, element_handler) ->
    @util.debug "initializing #{elements.length} click-elements"
    for element in elements
      element.addEventListener 'click', () ->
        element_handler this
      , false

  initialize_buttons: () ->
    @util.debug 'initializing all buttons'
    @initialize_click_elements_from_list document.getElementsByTagName('button'), @handler.handle_button_click

  initialize_links: () ->
    @util.debug 'initializing all links'
    @initialize_click_elements_from_list document.getElementsByTagName('a'), @handler.handle_link_click
