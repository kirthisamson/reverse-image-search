json.array!(@images) do |image|
  json.extract! image, :id, :name, :signature, :disc
  json.url image_url(image, format: :json)
end
