class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.datetime :start_time
      t.integer :start_address_id, index: true
      t.integer :end_address_id, index: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_foreign_key :departures, :addresses, column: :start_address_id
    add_foreign_key :departures, :addresses, column: :end_address_id
  end
end
