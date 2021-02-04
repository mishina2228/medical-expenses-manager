$(document).on('turbolinks:load', () => {
  $('button.dark-mode-toggle').click(() => {
    changeTheme()
  })
})

function changeTheme () {
  const Cookies = require('js-cookie')
  const body = $('body')
  body.toggleClass('dark_mode')
  const darkModeVal = body.hasClass('dark_mode') ? 'isActive' : 'notActive'
  Cookies.set('dark_mode', darkModeVal)
}
