# frozen_string_literal: true

json.extract! meeting, :id, :description, :date, :created_at, :updated_at
json.url meeting_url(meeting, format: :json)
