$(document).on('turbolinks:load', () => {
  const locale = $('body').data('locale')
  $('.date-picker').datetimepicker({
    format: 'YYYY-MM-DD',
    locale: locale
  })
  $('.month-picker').datetimepicker({
    format: 'YYYY-MM',
    locale: locale,
    viewMode: 'months'
  })
  $('.year-picker').datetimepicker({
    format: 'YYYY',
    locale: locale,
    viewMode: 'years'
  })
})
