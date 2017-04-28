require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './model/sensor'
require 'pry'

set :database, {adapter: "sqlite3", database: "rpi.sqlite3"}

sleep_upload_sec = 2 
sleep_sec = 60 
baseurl = "http://localhost:3000"
url = baseurl + "/sensors/1/measured_results" 
unit = 100
format = "%Y-%m-%d %H:%M:%S"

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
   data = sensors.map{ |session| ["raw_value",session.raw_value,"measured_at",session.measured_at.strftime(format)]}.map{|session| Hash[*session]}.to_json
   cmd = %Q|curl -H "Accept: application/json" -H "Content-type: application/json" #{url} -X POST -d "{\\"data\\":#{data.to_json.rchomp('"').chomp('"')}}"|
   puts cmd
   system(cmd)
   count = count+1
   sleep(sleep_upload_sec)
  end

  upload_sensors.each do |sensor|
    sensor.is_uploaded = true
    sensor.save
  end

  sleep(sleep_sec)
end

