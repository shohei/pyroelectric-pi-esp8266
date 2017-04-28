require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './model/sensor'
require 'timers'
require 'pry'

set :database, {adapter: "sqlite3", database: "rpi.sqlite3"}

sleep_upload_sec = 20 
sleep_sec = 6000
baseurl = "http://localhost:3000"
url = baseurl + "/sensors/1/measured_results" 
unit = 1

class String
  def rchomp(sep = $/)
    self.start_with?(sep) ? self[sep.size..-1] : self
  end
end

loop do
  upload_sensors = Sensor.where(:is_uploaded=> false)
  total = upload_sensors.count
  count = 0
  (total/unit + 1).times.each do
   sensors = upload_sensors.limit(unit).offset(count*unit)
   array_of_hash = sensors.to_a.map{|i| i.serializable_hash(except: %w(id number is_uploaded))}
   data = array_of_hash.to_json
   puts data
   cmd = %Q|curl -H "Accept: application/json" -H "Content-type: application/json" #{url} -X POST -d "{\\"data\\":#{data.rchomp('"').chomp('"')}}"|
   puts cmd
   system(cmd)
   count = count+1
   sleep(sleep_upload_sec)
  end
  sleep(sleep_sec)
end


