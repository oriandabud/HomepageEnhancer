json.array!(@popularities) do |popularity|
  json.extract! popularity, :id, :entrances, :user_id, :product_id
  json.url popularity_url(popularity, format: :json)
end
