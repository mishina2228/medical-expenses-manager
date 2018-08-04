$(document).on('turbolinks:load', (function () {
  $('.date-picker').datetimepicker({
    format: 'YYYY-MM-DD',
    locale: 'ja'
  });
}));
