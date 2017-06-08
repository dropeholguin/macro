# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

searchSession = ->
	$('#formSearch').submit (e) ->
		e.preventDefault()
		tag = $("#select-tag").find('option:selected').val();
		$.ajax
			type: 'POST'
			url: '/search_cards'
			data: $('#formSearch').serialize()+ "&the_tag=" + tag
			success: (data) ->

selectSession = ->
	$('#select-tag').change ->
		tag = $(this).find('option:selected').val();
		$.ajax
			type: 'POST'
			url: '/search_cards'
			data: the_tag: tag

$(document).on 'turbolinks:load', ->
	searchSession()
	selectSession()
