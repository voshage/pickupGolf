json.array!(@users) do |user|
  json.extract! user, :Helper, :Test, :Controller
  json.url user_url(user, format: :json)
end
