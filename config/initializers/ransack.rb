Ransack.configure do |config|

  # Change default search parameter key name.
  # Default key name is :q
  # config.search_key = :query

  config.add_predicate 'date_equals',
  arel_predicate: 'eq',
  formatter: proc {|v| v.to_date},
  validator: proc {|v| v.present?},
  type: :string
end
