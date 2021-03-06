class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.datetime :start_time
      t.integer :passenger_capacity
      t.string :frequency
      t.float :price
      t.references :start_address, index: true, foreign_key: true
      t.references :end_address, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
