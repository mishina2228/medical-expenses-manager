[![CI](https://github.com/mishina2228/medical-expenses-manager/workflows/ci/badge.svg)](https://github.com/mishina2228/medical-expenses-manager/actions)
[![Maintainability](https://api.codeclimate.com/v1/badges/58fc7e9f69118ecdb8ff/maintainability)](https://codeclimate.com/github/mishina2228/medical-expenses-manager/maintainability)
[![codecov](https://codecov.io/gh/mishina2228/medical-expenses-manager/branch/master/graph/badge.svg)](https://codecov.io/gh/mishina2228/medical-expenses-manager)
[![GitHub license](https://img.shields.io/github/license/mishina2228/medical-expenses-manager)](https://github.com/mishina2228/medical-expenses-manager/blob/master/LICENSE)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager?ref=badge_shield)

# medical_expenses_manager

Ruby on Rails application for managing medical expenses deductions

## Prerequisites

- Ruby 2.6+
- Node.js 10.22.1+ || 12+ || 14+
- Yarn 1.x+

## Installation

### Set up Rails app

First, install the gems and javascript packages required by the application:
```
bundle
yarn
```
Next, execute the database migrations/schema setup:
```
bundle exec rails db:setup
```

### Start the app

```
bundle exec rails assets:precompile RAILS_ENV=[RAILS_ENV]
bundle exec pumactl start -e [RAILS_ENV]
```

## License
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager?ref=badge_large)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
