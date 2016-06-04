class Departure < ActiveRecord::Base
  extend TimeSplitter::Accessors
  split_accessor :start_time

  belongs_to :user, :class_name => 'User'
  belongs_to :start_address, :class_name => 'Address'
  belongs_to :end_address, :class_name => 'Address'
end
