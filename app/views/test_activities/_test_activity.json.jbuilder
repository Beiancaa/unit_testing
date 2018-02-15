json.extract! test_activity, :id, :activity_url, :created_at, :updated_at
json.url test_activity_url(test_activity, format: :json)
