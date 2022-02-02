# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.2/lib/index.js"
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js", preload: true
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.1.3/dist/js/bootstrap.esm.js"
pin "@hotwired/turbo-rails", to: "https://ga.jspm.io/npm:@hotwired/turbo-rails@7.1.1/app/javascript/turbo/index.js"
pin "@hotwired/turbo", to: "https://ga.jspm.io/npm:@hotwired/turbo@7.1.0/dist/turbo.es2017-esm.js"
pin "@rails/actioncable/src", to: "https://ga.jspm.io/npm:@rails/actioncable@7.0.1/src/index.js"
pin "@nathanvda/cocoon", to: "https://ga.jspm.io/npm:@nathanvda/cocoon@1.2.14/cocoon.js"
pin "flatpickr", to: "https://ga.jspm.io/npm:flatpickr@4.6.9/dist/flatpickr.js"
pin "flatpickr/dist/plugins/monthSelect", to: "https://ga.jspm.io/npm:flatpickr@4.6.9/dist/plugins/monthSelect/index.js"
pin "flatpickr/dist/l10n/ja", to: "https://ga.jspm.io/npm:flatpickr@4.6.9/dist/l10n/ja.js"
pin "@fortawesome/fontawesome-svg-core", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-svg-core@1.2.36/index.es.js"
pin "@fortawesome/free-regular-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-regular-svg-icons@5.15.4/index.es.js"
pin "@fortawesome/free-solid-svg-icons", to: "https://ga.jspm.io/npm:@fortawesome/free-solid-svg-icons@5.15.4/index.es.js"
pin "emoji-toolkit", to: "https://ga.jspm.io/npm:emoji-toolkit@6.6.0/lib/js/joypixels.js"
pin "js-cookie", to: "https://ga.jspm.io/npm:js-cookie@3.0.1/dist/js.cookie.mjs"
pin_all_from "app/javascript/controllers", under: "controllers"
