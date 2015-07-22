$ ->
  $('.not-edited ').click (event) ->
    td = $(event.target).parent().parent()
    td.find('.edited').removeClass('hidden')
    td.find('.not-edited').addClass('hidden')
    event.preventDefault()