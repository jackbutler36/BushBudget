json.extract! user, :id, :first_name, :last_name, :street_address, :street_address_line_two, :city, :state, :zip_code,
              :phone_number, :is_admin, :is_committee_leader, :created_at, :updated_at
json.url user_url(user, format: :json)
