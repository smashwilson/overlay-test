{View} = require 'space-pen'

module.exports =
class OverlayTestView extends View

  @content: (editor) ->
    @div class: 'overlay-test', 'This is an overlay.'

  initialize: (@editor) ->

  attached: ->
    rightPosition = if @editor.verticallyScrollable()
        @editor.getVerticalScrollbarWidth()
      else
        0

    @parent().css right: rightPosition

    @css 'margin-top': -@editor.getLineHeightInPixels()
    @height @editor.getLineHeightInPixels()

  detached: ->
