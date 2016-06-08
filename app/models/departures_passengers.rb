class DeparturesPassengers < ActiveRecord::Base
  belongs_to :departure, :class_name => 'Departure'
  belongs_to :user, :class_name => 'User'
end
