class Sensor < ActiveRecord::Base
  validates_presence_of :raw_value
  validates_presence_of :measured_at
end
