json.array!(@users) do |user|
  json.extract! user, :name, :content
  json.url user_url(user, format: :json)
end
