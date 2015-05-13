json.array!(@categories) do |category|
  json.extract! category, :id, :page_link, :website_id
  json.url category_url(category, format: :json)
end
