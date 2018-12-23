$(document).on('turbolinks:load', (function () {
  const action_name = $('#division_action_name').val();
  $('.division_type').change(function () {
    load_division_ids($(this).val(), action_name);
  }).change();

  $('#reset_search').click(reset_search_form);

  $('#csv_loader').change(function () {
    prop_load_button($(this));
  }).change();
}));

function load_division_ids(klass_name, action_name) {
  $.ajax({
    url: '/divisions',
    type: 'GET',
    data: {klass: klass_name, name: action_name}
  }).done(function (data) {
    const $division_id_selector = $('#division_id_selector');
    $division_id_selector.html(data);
    const default_id = $('#division_default_id').val();
    if (default_id) {
      $division_id_selector.children('select').val(default_id);
    }
  })
}

function reset_search_form() {
  const forms = $('#search_record_form')
    .find('input[name^="search_record"], select[name^="search_record"]');
  forms.each(function (_, elem) {
    $(elem).val('');
  })
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
