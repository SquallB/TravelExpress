class CreateDeparturesPassengers < ActiveRecord::Migration
  def change
    create_table :departures_passengers do |t|
      t.integer :passengers_number
      t.references :departure
      t.references :user

      t.timestamps null: false
    end
  end
end
