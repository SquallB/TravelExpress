class Address < ActiveRecord::Base
  has_many :departure, :class_name => 'Departure'

  validates :line1,  presence: true, length: { maximum: 50 }
  validates :line2, length: { maximum: 50 }
  validates :city,  presence: true, length: { maximum: 50 }
  validates :zip,  length: { maximum: 18 }
  validates :state, length: { maximum: 50 }
end
