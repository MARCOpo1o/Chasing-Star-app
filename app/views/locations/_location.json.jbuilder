json.extract! location, :id, :location_name, :coordinates, :created_at, :updated_at
json.url location_url(location, format: :json)
