# medical-expenses-manager

[![CI](https://github.com/mishina2228/medical-expenses-manager/workflows/ci/badge.svg)](https://github.com/mishina2228/medical-expenses-manager/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/58fc7e9f69118ecdb8ff/maintainability)](https://codeclimate.com/github/mishina2228/medical-expenses-manager/maintainability)
[![codecov](https://codecov.io/gh/mishina2228/medical-expenses-manager/branch/master/graph/badge.svg)](https://codecov.io/gh/mishina2228/medical-expenses-manager)
[![GitHub license](https://img.shields.io/github/license/mishina2228/medical-expenses-manager)](https://github.com/mishina2228/medical-expenses-manager/blob/master/LICENSE)
[![JavaScript Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://standardjs.com)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager?ref=badge_shield)

Manager of medical expenses deductions

## Prerequisites

- Ruby 3.0+
- Node.js 12.22.0+ || 14.17.0+ || 16.0.0+
- Yarn 1.x+

## Installation

### Set up Rails app

First, install the gems and javascript packages required by the application:

```sh
bundle
yarn
```

Next, execute the database migrations/schema setup:

```sh
bin/rails db:setup
```

### Start the app

#### development

```sh
bin/rails start
```

#### production

```sh
bin/rails assets:precompile RAILS_ENV=production
bin/rails s -e production
```

## License

[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager?ref=badge_large)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
