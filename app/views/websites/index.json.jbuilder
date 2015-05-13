json.array!(@websites) do |website|
  json.extract! website, :id, :url, :name, :num_of_products, :product_name_selector, :product_url_selector, :product_picture_selector
  json.url website_url(website, format: :json)
end
