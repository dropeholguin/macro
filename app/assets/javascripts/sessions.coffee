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

selectSession = ->
	$('#select-tag').change ->
		tag = $(this).find('option:selected').val();
		title = $("input[name='session[title]']").val();
		console.log title
		window.location = "new?title="+ title + "&the_tag=" + tag

$(document).on 'turbolinks:load', selectSession
$(document).ready selectSession
