import emojiToolkit from 'emoji-toolkit'

window.addEventListener('turbolinks:load', () => {
  emojify()

  $('.division_type').on('change', event => {
    loadDivisionIds($(event.currentTarget).val())
  })

  $('#reset_search').on('click', resetSearchForm)

  $('#csv_loader').on('change', event => {
    propLoadButton($(event.currentTarget))
  }).change()
})

const loadDivisionIds = klassName => {
  window.fetch(`/divisions?klass=${klassName}`)
    .then(response => response.json())
    .then(json => {
      const $divisionId = $('.division_id')
      replaceSelectOptions($divisionId, json)
      const defaultId = $('#division_default_id').val()
      if (defaultId) {
        $divisionId.val(defaultId)
      }
    })
}

const replaceSelectOptions = ($select, results) => {
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

const resetSearchForm = () => {
  const $forms = $('#search_record_form')
    .find('input[name^="search_record"], select[name^="search_record"]')
  $forms.each((_, elem) => $(elem).val(''))
}

const propLoadButton = $csvLoader => {
  const $csvLoadButton = $('#csv_load_button')
  if ($csvLoader[0].files[0] && extname($csvLoader[0].files[0].name) === 'csv') {
    $csvLoadButton.prop('disabled', false)
  } else {
    $csvLoadButton.prop('disabled', true)
  }
}

const extname = path => {
  const array = path.split('.')
  return array[array.length - 1].toLowerCase()
}

const emojify = () => {
  $('.emojify').each((_, elem) => {
    const emojified = emojiToolkit.toImage($(elem).html())
    $(elem).html(emojified)
  })
}
