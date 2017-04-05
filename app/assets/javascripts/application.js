// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require bootstrap
//= require summernote
//= require react
//= require react_ujs
//= require simplemde.min
//= require components
//= require cocoon
//= require_tree .
window.Components = {} 
//Choose your name. Do not use React here or
//you'll overwrite library functions
$(function(){ $(document).foundation(); });
$(document).on("turbolinks:load", function() {
  var simplemde = new SimpleMDE({ element: document.getElementById("description") });
  var simplemde = new SimpleMDE({	element: document.getElementById("explanation")});
});