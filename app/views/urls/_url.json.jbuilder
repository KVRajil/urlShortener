json.extract! url, :id, :shortened_url, :original_url, :is_deleted, :created_at, :updated_at
json.url url_url(url, format: :json)
