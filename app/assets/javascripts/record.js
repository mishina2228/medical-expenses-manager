$(document).on('turbolinks:load', (function () {
  const $record_division_type = $('.division_type');
  load_division_ids($record_division_type.val());

  $record_division_type.change(function () {
    load_division_ids($record_division_type.val());
  });

  function load_division_ids(klass_name) {
    $.ajax({
      url: '/divisions',
      type: 'GET',
      data: {klass: klass_name}
    }).done(function (data) {
      const $division_id_selector = $('#division_id_selector');
      $division_id_selector.html(data);
      const default_id = $('#division_default_id').val();
      if (default_id) {
        $division_id_selector.children('select').val(default_id);
      }
    })
  }
}));