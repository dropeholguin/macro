# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

payPhotos = ->
	$('#json').click ->
		$.ajax 'sessions_next_card',
		type: 'POST',
		dataType: 'json',
		error: ->
			console.log("AJAX Error: #{textStatus}")
		success: (data) ->
			console.log(data)

pay = ->
	$('#run').click ->
		$.ajax '/run_card',
		type: 'POST',
		dataType: 'json',
		error: ->
			console.log("AJAX Error: #{textStatus}")
		success: (data) ->
			console.log("RUN CAR")

$(document).ready payPhotos
$(document).ready pay

$(document).on 'turbolinks:load', ->
	payPhotos()
	pay()