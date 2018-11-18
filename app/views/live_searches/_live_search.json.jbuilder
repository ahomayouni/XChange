json.extract! live_search, :id, :user_id, :title, :category, :from_when, :to_when, :where, :created_at, :updated_at
json.url live_search_url(live_search, format: :json)
