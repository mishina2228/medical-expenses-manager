$(document).on('turbolinks:load', (() => {
  emojify();

  $('.division_type').on('change', event => {
    load_division_ids($(event.currentTarget).val());
  });

  $('#reset_search').on('click', reset_search_form);

  $('#csv_loader').on('change', event => {
    prop_load_button($(event.currentTarget));
  }).change();

  add_data_on_add_fields();
}));

function load_division_ids(klass_name) {
  $.ajax({
    url: '/divisions',
    type: 'GET',
    data: {klass: klass_name}
  }).done(json => {
    const $division_id = $('.division_id');
    replace_select_options($division_id, json);
    const default_id = $('#division_default_id').val();
    if (default_id) {
      $division_id.val(default_id);
    }
  })
}

function replace_select_options($select, results) {
  $select.html($('<option>'));
  $(results).each((_, elem) => {
    const option = $('<option>').val(elem.id).text(elem.name);
    $select.append(option)
  });
  if (results.length === 0) {
    $select.prop('disabled', true);
  } else {
    $select.prop('disabled', false);
  }
}

function reset_search_form() {
  const $forms = $('#search_record_form')
    .find('input[name^="search_record"], select[name^="search_record"]');
  $forms.each((_, elem) => $(elem).val(''))
}

function prop_load_button($csv_loader) {
  const $csv_load_button = $('#csv_load_button');
  if ($csv_loader[0].files[0] && extname($csv_loader[0].files[0].name) === 'csv') {
    $csv_load_button.prop('disabled', false);
  } else {
    $csv_load_button.prop('disabled', true);
  }
}

function extname(path) {
  const array = path.split('.');
  return array[array.length - 1].toLowerCase();
}

function emojify() {
  const emojione = require('emojione')
  $('.emojify').each((_, elem) => {
    const emojified = emojione.toImage($(elem).html());
    $(elem).html(emojified);
  });
}

function add_data_on_add_fields() {
  $("a.add_fields")
    .data("association-insertion-method", 'append')
    .data("association-insertion-node", '#hospital-transports');
}
