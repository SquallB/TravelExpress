class Address < ActiveRecord::Base
  belongs_to :departure, :class_name => "Departure", :foreign_key => :start_address_id
  belongs_to :departure, :class_name => "Departure", :foreign_key => :end_address_id
end
