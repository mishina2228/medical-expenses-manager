# frozen_string_literal: true

Rails.autoloaders.each do |autoloader|
  autoloader.inflector.inflect(
    'record_csv' => 'RecordCSV'
  )
end
