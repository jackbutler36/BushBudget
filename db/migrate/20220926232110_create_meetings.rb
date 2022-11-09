# frozen_string_literal: true

class CreateMeetings < ActiveRecord::Migration[6.1]
  def change
    create_table :meetings do |t|
      t.string :description
      t.date :date
      t.string :password

      t.timestamps
    end
  end
end
