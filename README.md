[![CircleCI](https://circleci.com/gh/mishina2228/medical-expenses-manager.svg?style=svg)](https://circleci.com/gh/mishina2228/medical-expenses-manager)
[![Maintainability](https://api.codeclimate.com/v1/badges/58fc7e9f69118ecdb8ff/maintainability)](https://codeclimate.com/github/mishina2228/medical-expenses-manager/maintainability)
[![codecov](https://codecov.io/gh/mishina2228/medical-expenses-manager/branch/master/graph/badge.svg)](https://codecov.io/gh/mishina2228/medical-expenses-manager)
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fmishina2228%2Fmedical-expenses-manager?ref=badge_shield)

# medical_expenses_manager

Ruby on Rails application for managing medical expenses deductions

## Prerequisites

- Ruby 2.5+
- Node.js 10.22.1+ || 12+ || 14+
- Yarn 1.x+

## Installation

### Set up Rails app

First, install the gems required by the application:
```
bundle
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
