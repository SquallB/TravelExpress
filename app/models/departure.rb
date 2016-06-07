class Departure < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :start_time

  belongs_to :user, :class_name => 'User'
  belongs_to :start_address, :class_name => 'Address'
  belongs_to :end_address, :class_name => 'Address'

  def self.search(start_city, end_city, start_date_date, start_date_time, passengers)
    if start_city && end_city
      joins(:start_address, :end_address).where(
          '(addresses.id = departures.start_address_id AND addresses.city LIKE ?)
              AND (addresses.id = departures.end_address_id AND addresses.city LIKE ?)
              AND (departures.passenger_capacity >= ?)',
          "%#{start_city}%", "%#{end_city}%", "%#{passengers}")
    else
      []
    end
  end
end
