json.extract! user, :id, :user_name, :email, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
