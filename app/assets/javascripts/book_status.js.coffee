$(".filter").change ->
  var value = $(this).val()
  $.ajax
    url: <%= users_path(:json) %>,
    type: 'GET',
    data: value,
    success: (data)
      $(".book_status_list").html(data.book_statues)
