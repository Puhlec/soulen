json.extract! instructor, :id, :name, :password_digest, :created_at, :updated_at
json.url instructor_url(instructor, format: :json)
