class Departure < ActiveRecord::Base
  belongs_to :user
  has_one :start_address, foreign_key => "start_address_id", class_name => "Address"
  has_one :end_address, foreign_key => "end_address_id", class_name => "Address"
end
