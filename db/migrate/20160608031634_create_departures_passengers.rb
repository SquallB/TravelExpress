class CreateDeparturesPassengers < ActiveRecord::Migration
  def change
    create_table :departures_passengers do |t|
      t.integer :passengers_number
      t.references :departure, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
