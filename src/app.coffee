class Todo extends Backbone.Model

	defaults: ->
		title : "empty todo..."
		order: ''
		done: false

	initialize: ->

	toggle: ->
		@save {done: !this.get("done")}

	clear: ->
		@destroy()

class TodoList extends Backbone.Collection

	model: Todo

	localStorage: new Store("todos-backbone")

	done : ->
		@filter (todo)->
			todo.get("done")


class TodoView extends Backbone.View

	tagName: 'li'

	template: _.template($('#item-template').html())

	events: 
		"click input" : "toggleDone"
		"click a.destroy" : "clear"
		"dblclick label" : "edit"
		"blur .edit" : "editDone"

	initialize : ->
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

class AppView extends Backbone.View

	el : $ '#todoapp'

	events: 
		'keypress #new-todo' : 'handleKeypress'
		'click #clear-completed' : 'clearCompleted'

	initialize: ->
		Todos.bind('add', @addTodo, @)
		Todos.bind('reset', @addAll, @)
		Todos.bind('all', @render, @)

		Todos.fetch()

	render: ->
		console.log "all?"

	addAll: ->
		Todos.each @addTodo


	handleKeypress: (e) ->
		if e.keyCode is 13
			Todos.create { title: $(e.target).val() }
			$(e.target).val("")

	addTodo: (model) ->
		view = new TodoView {model : model}
		@$('#todo-list').append(view.render().el)

	clearCompleted: ->
		_.each(Todos.done(), (todo)-> todo.destroy() )


Todos = new TodoList
app = new AppView