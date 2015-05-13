json.array!(@products) do |product|
  json.extract! product, :id, :page_link, :picture_link, :title, :website_id
  json.url product_url(product, format: :json)
end
