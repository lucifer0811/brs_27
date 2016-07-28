// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.raty
//= require ratyrate
//$(document).on 'ready page:load', ->
//  $('div.alert-danger').delay(3000).slideUp()
//  $('div.alert-success').delay(3000).slideUp()
// cancel_function = ->
//    window.history.back()
$(document).ready(function(){
  $('#favorite_book_panel').hide();
  $('#read_book_panel').hide();
  $('#reading_book_panel').hide();
})
