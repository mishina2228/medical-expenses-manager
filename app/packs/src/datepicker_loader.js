import flatpickr from 'flatpickr'
import monthSelectPlugin from 'flatpickr/dist/plugins/monthSelect'
import { Japanese } from 'flatpickr/dist/l10n/ja'

const localeDict = {
  en: null,
  ja: Japanese
}

window.addEventListener('turbolinks:load', () => {
  const locale = document.getElementsByTagName('body')[0].getAttribute('data-locale')
  flatpickr('.date-picker', {
    allowInput: true,
    locale: localeDict[locale]
  })
  flatpickr('.month-picker', {
    allowInput: true,
    locale: localeDict[locale],
    plugins: [
      monthSelectPlugin({
        dateFormat: 'Y-m'
      })
    ]
  })
})
