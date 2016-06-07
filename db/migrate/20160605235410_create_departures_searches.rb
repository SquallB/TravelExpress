class CreateDeparturesSearches < ActiveRecord::Migration
  def change
    create_table :departures_searches do |t|
      t.string :start_city
      t.string :end_city
      t.string :start_date
      t.integer :passengers

      t.timestamps null: false
    end
  end
end
