define [
	'jQuery'
	'Underscore'
	'Backbone'
], ($, _, Backbone) ->

	TodoView = Backbone.View.extend

		tagName: 'li'

		template: _.template($('#item-template').html())

		events: 
			"click input" : "toggleDone"
			"click a.destroy" : "clear"
			"dblclick label" : "edit"
			"blur .edit" : "editDone"

		initialize : ->
			if @model
				@model.bind('destroy', @remove, @)

		render : ->
			@$el.html(@.template(@.model.toJSON()))
			@

		edit : ->
			@$el.addClass 'editing'
			@$('.edit').focus()

		editDone : ->
			@$el.removeClass 'editing'
			
		toggleDone : ->
			@model.toggle()

		clear : ->
			console.log 'remove?'
			@model.clear()