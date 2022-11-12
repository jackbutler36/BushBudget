# frozen_string_literal: true

json.extract! attendance, :id, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
