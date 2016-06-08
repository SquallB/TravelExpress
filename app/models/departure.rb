class Departure < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :start_time

  belongs_to :user, :class_name => 'User'
  belongs_to :start_address, :class_name => 'Address'
  belongs_to :end_address, :class_name => 'Address'

  validates :start_time,  presence: true
  validates :user,  presence: true
  validates :start_address,  presence: true
  validates :end_address,  presence: true
  validates :passenger_capacity,  numericality: true
  validates :price,  numericality: true

  def self.search(start_city, end_city, start_time, passengers)
    if start_city && end_city
      joins('INNER JOIN addresses AS start_address ON start_address.id = departures.start_address_id
      INNER JOIN addresses AS end_address ON end_address.id = departures.end_address_id').
      where('start_address.city LIKE ?
         AND end_address.city LIKE ?
         AND departures.start_time >= ?
         AND departures.passenger_capacity >= ?',
          "%#{start_city}%", "%#{end_city}%", start_time, passengers)
    else
      []
    end
  end
end
