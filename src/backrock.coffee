#     Backrock 0.0.1

#     (c) 2013 Mark Fayngersh
#     Backrock may be freely distributed under the MIT license.
#     For all details and documentation:
#     http://github.com/pheuter/backrock


# ## Setup

# Reference to global object.
root = this

# Top-level namespace.
if exports?
  Backrock = exports
else
  Backrock = root.Backrock = {}

# Current version of library.
Backrock.VERSION = '0.0.1'


# ## View
# 
# Manages the representation and behavior of a Meteor **template**.
Backrock.View = class View

  # A View expects.
  constructor: (options) ->
    {template} = options
    @_template = Template[template]

    if @_template?
      @_attachListeners()
      @_attachEvents()
      @_attachHelpers()

      @initialize?(arguments[0])
    else
      throw new Error "Template '#{name}' does not exist!"

  _attachListeners: ->
    _this = this

    @_template.created = ->
      _this.created?(this)

    @_template.rendered = ->
      _this.rendered?(this)

    @_template.destroyed = ->
      _this.destroyed?(this)

  _attachEvents: ->
    events = {}
    events[sel] = this[func] for sel, func of @events
    @_template.events = events

  _attachHelpers: ->
    helpers = {}
    helpers[name] = this[func] for name, func of @helpers
    @_template.helpers(helpers)