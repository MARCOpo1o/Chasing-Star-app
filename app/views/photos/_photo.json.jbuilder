json.extract! photo, :id, :image_url, :shooting_time, :uploader_id, :post_id, :location_id, :created_at, :updated_at
json.url photo_url(photo, format: :json)
