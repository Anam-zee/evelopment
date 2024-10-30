json.extract! event, :id, :name, :description, :date, :location, :organizer, :created_at, :updated_at
json.url event_url(event, format: :json)
