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
//= require react
//= require react_ujs
//= require simplemde.min
//= require components
//= require cocoon
//= require prism
//= require_tree .
//= require jquery.countdown
window.Components = {} 
//Choose your name. Do not use React here or
//you'll overwrite library functions
$(function(){ $(document).foundation(); });
$(document).on("turbolinks:load", function() {
  var simplemde = new SimpleMDE({ 
    element: document.getElementById("description"),
    previewRender: function(plainText, preview) {
      setTimeout(function() {
        preview.innerHTML = this.parent.markdown(plainText).replace(/<code>/g, '<code class="language-sas">');
        Prism.highlightAll();
      }.bind(this), 1)
      return "Loading..."
    },
    renderingConfig: {
      codeSyntaxHighlighting: true,
    }
  });
  var simplemde = new SimpleMDE({
    element: document.getElementById("explanation"),
    previewRender: function(plainText, preview) {
      setTimeout(function() {
        preview.innerHTML = this.parent.markdown(plainText).replace(/<code>/g, '<code class="language-sas">');
        Prism.highlightAll();
      }.bind(this), 1)
      return "Loading..."
    },
    renderingConfig: {
      codeSyntaxHighlighting: true,
    }
  });
});
