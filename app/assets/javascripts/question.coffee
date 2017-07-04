# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#title_autocomplete').autocomplete source: $('#title_autocomplete').data('autocomplete-source')

@initTagInput = ->
  $('#question_tag_list').tagsInput
    'defaultText': 'add...'
    'autocomplete_url': ''
    'autocomplete': 'source': $('#question_tag_list').data("topics")
  return

notification = ->
  $('#notification_li').click ->
    $.ajax
      type: 'POST'
      url: '/notification_state'

$(document).on 'turbolinks:load', ->
  notification()
