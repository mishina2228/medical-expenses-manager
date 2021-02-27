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
      const divisionId = document.getElementById('division-id-select')
      replaceSelectOptions(divisionId, json)
    })
}

const replaceSelectOptions = (select, results) => {
  select.textContent = ''
  select.insertAdjacentElement('beforeend', document.createElement('option')) // empty option
  results.forEach(elem => {
    const option = document.createElement('option')
    option.value = elem.id
    option.text = elem.name
    select.insertAdjacentElement('beforeend', option)
  })
  select.disabled = results.length === 0
}

const resetSearchForm = () => {
  const form = document.getElementById('search_record_form')
  const fields = form.querySelectorAll('input[name^="search_record"], select[name^="search_record"]')
  fields.forEach(elem => { elem.value = '' })
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
  document.querySelectorAll('.emojify').forEach(elem => {
    elem.innerHTML = emojiToolkit.toImage(elem.innerHTML)
  })
}
