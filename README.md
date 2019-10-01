# medical_expenses_manager

医療費控除管理アプリ

お試しで作成

# Commands

### ソース更新時の作業

```
bundle
bundle exec rake assets:precompile RAILS_ENV=[RAILS_ENV]
bundle exec pumactl start -F config/puma/[RAILS_ENV].rb
```
