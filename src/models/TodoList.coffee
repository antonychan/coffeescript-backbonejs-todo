define [
	'Underscore'
	'Backbone'
	'libs/backbone-localstorage'
	'models/TodoModel'
], (_, Backbone, Store, Todo) ->

	TodoList = Backbone.Collection.extend

		model: Todo

		localStorage: new Store("todos-backbone")

		done : ->
			@filter (todo)->
				todo.get("done")