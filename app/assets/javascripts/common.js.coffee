$(document).on 'ready page:load', ->
  $('div.alert-danger').delay(2500).slideUp()
  $('div.alert-success').delay(2500).slideUp()
  cancel_function = ->
    window.history.back()
