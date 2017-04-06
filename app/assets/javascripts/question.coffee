# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#title_autocomplete').autocomplete source: $('#title_autocomplete').data('autocomplete-source')

initTagInput = ->
  tags_array = [
    'SAS Management Console'
    'SAS Macro'
    'DI Studio'
    'Enterprise Guide'
    'SAS Programming'
    'Workspace Management'
  ]
  $('#tags_addTag').tagsInput
    'defaultText': 'add...'
    'autocomplete_url': ''
    'autocomplete': 'source': tags_array
  return

$(document).ready initTagInput
$(document).on 'page:load', initTagInput
