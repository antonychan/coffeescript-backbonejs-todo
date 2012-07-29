define [
	'jQuery'
	'Underscore'
	'Backbone'
	'models/TodoModel'
	'views/TodoView'
	'models/TodoList'
], ($, _, Backbone, Todo, TodoView, TodoList) ->

	AppView = Backbone.View.extend 

		el : $ '#todoapp'

		events: 
			'keypress #new-todo' : 'handleKeypress'
			'click #clear-completed' : 'clearCompleted'

		initialize: ->
			@Todos = new TodoList

			@Todos.bind('add', @addTodo, @)
			@Todos.bind('reset', @addAll, @)
			@Todos.bind('all', @render, @)

			@Todos.fetch()

		addAll: ->
			@Todos.each @addTodo


		handleKeypress: (e) ->
			if e.keyCode is 13
				@Todos.create { title: $(e.target).val() }
				$(e.target).val("")

		addTodo: (model) ->
			view = new TodoView {model : model}
			@$('#todo-list').append(view.render().el)

		clearCompleted: ->
			_.each(@Todos.done(), (todo)-> todo.destroy() )