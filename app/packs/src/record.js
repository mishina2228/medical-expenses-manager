$(document).on('turbolinks:load', () => {
  emojify()

  $('.division_type').on('change', event => {
    loadDivisionIds($(event.currentTarget).val())
  })

  $('#reset_search').on('click', resetSearchForm)

  $('#csv_loader').on('change', event => {
    propLoadButton($(event.currentTarget))
  }).change()

  addDataOnAddFields()
})

function loadDivisionIds (klassName) {
  $.ajax({
    url: '/divisions',
    type: 'GET',
    data: { klass: klassName }
  }).done(json => {
    const $divisionId = $('.division_id')
    replaceSelectOptions($divisionId, json)
    const defaultId = $('#division_default_id').val()
    if (defaultId) {
      $divisionId.val(defaultId)
    }
  })
}

function replaceSelectOptions ($select, results) {
  $select.html($('<option>'))
  $(results).each((_, elem) => {
    const option = $('<option>').val(elem.id).text(elem.name)
    $select.append(option)
  })
  if (results.length === 0) {
    $select.prop('disabled', true)
  } else {
    $select.prop('disabled', false)
  }
}

function resetSearchForm () {
  const $forms = $('#search_record_form')
    .find('input[name^="search_record"], select[name^="search_record"]')
  $forms.each((_, elem) => $(elem).val(''))
}

function propLoadButton ($csvLoader) {
  const $csvLoadButton = $('#csv_load_button')
  if ($csvLoader[0].files[0] && extname($csvLoader[0].files[0].name) === 'csv') {
    $csvLoadButton.prop('disabled', false)
  } else {
    $csvLoadButton.prop('disabled', true)
  }
}

function extname (path) {
  const array = path.split('.')
  return array[array.length - 1].toLowerCase()
}

function emojify () {
  const emojione = require('emojione')
  $('.emojify').each((_, elem) => {
    const emojified = emojione.toImage($(elem).html())
    $(elem).html(emojified)
  })
}

function addDataOnAddFields () {
  $('a.add_fields')
    .data('association-insertion-method', 'append')
    .data('association-insertion-node', '#hospital-transports')
}
