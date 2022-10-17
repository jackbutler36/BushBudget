class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :street_address
      t.string :street_address_line_two
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number
      t.string :uin
      t.string :position
      t.string :committee
      t.date :excusal_date

      t.timestamps
    end
  end
end
