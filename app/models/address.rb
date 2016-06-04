class Address < ActiveRecord::Base
  has_many :departure, :class_name => 'Departure'
end
