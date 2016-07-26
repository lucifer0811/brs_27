$(document).on 'ready page:load', ->
  $('div.alert-danger').delay(3000).slideUp()
  $('div.alert-success').delay(3000).slideUp()
  cancel_function = ->
    window.history.back()
