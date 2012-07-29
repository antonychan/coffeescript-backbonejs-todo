define [
	'Underscore'
	'Backbone'
], (_, Backbone) ->

	Todo = Backbone.Model.extend
	
		defaults: ->
			title : "empty todo..."
			order: ''
			done: false

		initialize: ->

		toggle: ->
			@save {done: !this.get("done")}

		clear: ->
			@destroy()