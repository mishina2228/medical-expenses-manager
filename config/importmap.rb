# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/dist/esm/index.js"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.3/dist/js/bootstrap.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@oddcamp/cocoon-vanilla-js", to: "https://ga.jspm.io/npm:@oddcamp/cocoon-vanilla-js@1.1.3/index.js"
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/flatpickr.js"
pin "flatpickr/dist/plugins/monthSelect", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/plugins/monthSelect/index.js"
pin "flatpickr/dist/l10n/ja", to: "https://ga.jspm.io/npm:flatpickr@4.6.13/dist/l10n/ja.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@6.7.1/index.mjs"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@6.7.1/index.mjs"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@6.7.1/index.mjs"
pin "emoji-toolkit", to: "https://ga.jspm.io/npm:emoji-toolkit@9.0.1/lib/js/joypixels.js"
pin "js-cookie", to: "https://ga.jspm.io/npm:js-cookie@3.0.5/dist/js.cookie.mjs"
pin_all_from "app/javascript/controllers", under: "controllers"
