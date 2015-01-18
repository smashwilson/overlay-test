OverlayTestView = require './overlay-test-view'
{CompositeDisposable} = require 'atom'
util = require 'util'

module.exports = OverlayTest =
  subs: null
  markers: null

  activate: (state) ->
    @subs = new CompositeDisposable
    @subs.add atom.commands.add 'atom-workspace', 'overlay-test:toggle': => @toggle()

  deactivate: ->
    @subs.dispose()
    if @markers?
      m.destroy() for m in @markers

  toggle: ->
    if @markers?
      m.destroy() for m in @markers
      @markers = null
      console.log 'Overlay: off'
      return

    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    for range in editor.getSelectedBufferRanges()
      @markers ?= []

      console.log "Marking: #{util.inspect range}"
      m = editor.markBufferRange range,
        persistent: false,
        invalidate: 'never'
      editor.decorateMarker m,
        type: 'overlay',
        item: new OverlayTestView(editor),
        position: 'tail'
      @markers.push m

    if @markers?
      console.log 'Overlay: on'
    else
      console.log 'Nothing to mark.'
